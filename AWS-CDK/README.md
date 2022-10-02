# AWS Cloud Development Kit  
[AWS CDS User Guide](https://docs.aws.amazon.com/cdk/v2/guide/getting_started.html)  
[AWS CDK API References](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-construct-library.html)

## Chapter 1: Getting started
The output of an AWS CDK program is an AWS CloudFormation template.  

__AWS CDS Apps__   
An AWS CDK _app_ is an applications that is written in a programming language of your choice that uses the AWS CDK to define AWS infrastructure.  

__Stacks and Constructs__  
A CDK app defines one or more _stacks_. Stacks contains _constructs_, each of which defined one or more concrete AWS resources such as an S3 bucket, a Lambda functions, a DynamoDB table and so on.  
_Constructs_ are represented as classes in your programming language of choice.  You instantiate constructs within a stack to declare them to AWS, and connect them to each other using well-defined interfaces.  

__AWS CDK Toolkit__  
The AWS CDK toolkit is a CLI tool for working with you AWS CDK apps and stacks. The toolkit provides the ability to convert one or more AWS CDK stacks to AWS CloudFormation templates and related assets (in a process called _synthesis_) and deploy your stacks to an AWS account.   
It also has diff, deletion and troubleshooting capabilities.  

__The Construct Library__  
The AWS CDK includes a library of AWS constructs called the AWS Construct library, organized into various modules. The library contains construct for each AWS service. The main CDK package contains majority of the AWS construct Library along with base classes like _Stack_ and _App_ used in mode CDK applications.   
To install AWS CDK library  
```
$ npm install aws-cdk-lib
```   
__Flavours of constructs__  
Constructs come in three flavours:   
1. __AWS CloudFormation-only or L1__: corresponds directly to resources types defined by AWS CloudFormation. For example _CfnBucket_ is the L1 construct for an Amazon S3 bucket. All L1 resources are in `aws-cdk-lib`.    
2. __Curate or L2__:  developed by AWS CDK team to address specific use cases and simplify infrastructure development. They encapsulate L1 resources, providing sensible defaults and best-practice security policies. For example, _Bucket_ is the L2 construct for an S3 bucket.  
3. __Patterns or L3__:  declares multiple resources to create entire AWS architectures for particular use cases. All the plumbing is already hooked up, and configuration is boiled down to a few important parameters.  

The _constructs_ package contains the `Construct` base class. It is used not only by AWS CDK but tools like CDK for Terraform and CDK for Kubernetes.  
For other third party constructs compatible with AWS CDK checkout [Construct Hub](https://constructs.dev/search?q=&cdk=aws-cdk&cdkver=2&offset=0).


__Prerequisite__  
* __Node.js 10.13.0 or above__  
This applies to any language you choice to write your CDK app in. Node 13.0.0 through 13.6.0 are not compatible.  
* __AWS CLI__  
Install and configure AWS CLI  
If you are using a profile, you must have a profile of the same name in your `~/.aws/config` file as well as your `~/.aws/credential` file.  
* __AWS CDK Toolkit__  
Install the AWS CDK Toolkit globally
```
$ npm install -g aws-cdk
$ cdk --version
$ cdk --help
```
* __SDK for you chosen language__  
If you chosen language is Java for example, then you install the JDK, IDE and other development tooling.

__Bootstrapping__  
Bootstrapping creates the S3 bucket (used to store templates and assets) and other containers required by AWS CloudFormation during the deployment of stacks.  
```
$ cdk bootstrap aws://my-account-number/my-aws-region  
```  
To get your account number
```
$ aws sts get-caller-identity
```
To display your default region
```
$ aws configure get region
```

__IDE Plugin__  
Install the AWS Toolkit for Visual Studio Code extension if you are using VSCode.
The toolkit provides an integrated experience for developing AWS CDK applications, including the AWS CDK Explorer feature to list your AWS CDK projects and browse the various components of the CDK application. [AWS Toolkit for Visual Studio Code](https://aws.amazon.com/visualstudiocode/)

__References__   
[Working with the AWS CDK in TypeScript](https://docs.aws.amazon.com/cdk/v2/guide/work-with-cdk-typescript.html)   
[AWS CDK Toolkit (cdk command)](https://docs.aws.amazon.com/cdk/v2/guide/cli.html)  
[Installing the AWS Toolkit for Visual Studio Code](https://docs.aws.amazon.com/toolkit-for-vscode/latest/userguide/setup-toolkit.html)

## Chapter 2: AWS CDK Application  
__AW CDK Development workflow__  
1. Create the app from a template provided by the AWS CDK
```
$ cdk  init app --language typescript
```
2. Add code to the app to create resources within stacks
3. Build the app (optional; the AWS CDK Toolkit will do it for you if you forget)
```
$ npm run build
```
4. Synthesize one or more stacks in the app to create an AWS CloudFormation template
```
$ cdk synth
```
5. Deploy one or more stacks to your AWS account

__Create a CDK project__  
First create the directory
```
$ mkdir hello-cdk
$ cd hello-cdk
```  
While inside the directory, initialize the app using the `cdk init` command with the `app` template and your chosen programming language.
```
$ cdk  init app --language typescript
```  
The template is optional and `app` is the default template.  

__For C# Project__  
Create and build C# project
```
$ mkdir HelloCDK
$ cd HelloCDK
$ cdk init app --language csharp
$ dotnet build src
```
To build you can also press F6 in Visual Studio.  

__Useful commands for CDK project__  

Command         | Description
----------------|--------------
`npm run build` | compile typescript to js
`npm run watch` | watch for changes and compile
`npm run test`  | perform the jest unit tests
`cdk ls`        | list your stacks
`cdk synth`     | emits the synthesized CloudFormation template  
`cdk deploy`    | deploy this stack to your default AWS account/region
`cdk diff`      | compare deployed stack with current state
`cdk doctor` | Checks your CDK project for potential problems
`cdk metadata` | Displays metadata about the specified stack
`cdk context` | Manages cached context values

Learn more at [AWS ToolKit CLI](https://docs.aws.amazon.com/cdk/v2/guide/cli.html)

__Synthensize a CF template__  
To synthesize CloudFormation template
```
$ cdk synth
```  
If your app contains more than one stack you need to specify the stack to synthesize.  
The `cdk synth` generates a perfectly valid AWS CloudFormation template. You could take it and deploy it using the AWS CloudFormation console or another tool. But the AWS CDK Toolkit can also do that.   

__Deploying a stack__  
To deploy a stack
```
$ cdk deploy
```  
If your app contains more than one stacks, you need to specify the stack to deploy.  

To see all your deployed stacks
```
$ aws cloudformation describe-stacks
```
To see all the resources provisioned by the stack
```
$ aws cloudformation describe-stack-resources --stack-name MyStackName
```
To see the details of a specific resource of the stack
```
$ aws cloudformation describe-stack-resource --stack-name CdkWorkshopStack --logical-resource-id CdkWorkshopQueue50D9D426
```  

__Modifying a stack__  
After modifying your constructs, run the _cdk diff_ command to generate a CloudFormation change set.    
```
$ cdk diff
```  

__Destroying the stack__  
To delete the stack
```
$ cdk destroy
```  
The will delete the stack and may delete the resources depending on the resource's deletion policy.   
 For example you can set a S3 bucket removal policy to _DESTROY_ so that it will be deleted when the stack is delete.  

__Reference__
[Working with the AWS CDK in C#](https://docs.aws.amazon.com/cdk/v2/guide/work-with-cdk-csharp.html)   
[AWS CDK Examples](https://github.com/aws-samples/aws-cdk-examples)

## Chapter 3: CDK Workshop  
[CDK Workshop](https://cdkworkshop.com/)

__Create the application__  
```
$ mkdir cdk-workshop
$ cd cdk-workshop
$ cdk init sample-app --language typescript
```

__CDK Deploy hotswap__  
To make deployment  faster in some cases, during development, you may use the _hotswap_ flag.
```
$ cdk deploy --hotswap
```
This will make the deployment faster when there are _hotswappable_ changes.
The _hotswap_ flag should only be used in development but never on production stack.  

__CDK Watch__  
CDK watch monitors your code and assets for changes and attempts to perform a deployment automatically when a change is detected.   
Once we set it up, we can use _cdk watch_ to detect both _hotswappable_ changes and changes that require full CloudFormation deployment.
```
$ cdk watch
```
This will trigger an initial deployment and immediately begin observing the files we’ve specified in `cdk.json`.  
The `cdk.json` file lists the files to be included/excluded from being watched.  
To learn more about CDK watch see [Increasing development speed with CDK Watch](https://aws.amazon.com/blogs/developer/increasing-development-speed-with-cdk-watch/)


## Chapter 4: Concept  

## Chapter 5: Writing Constructs
[Workshop  d](https://cdkworkshop.com/20-typescript/40-hit-counter.html)

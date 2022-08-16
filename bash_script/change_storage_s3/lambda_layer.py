import { App, CfnOutput, Construct, Stack, StackProps } from '@aws-cdk/core';
import * as layer from '@aws-cdk/lambda-layer-awscli';

export class MyStack extends Stack {
  constructor(scope: Construct, id: string, props: StackProps = {}) {
    super(scope, id, props);

    const awscliLayer = new layer.AwsCliLayer(this, 'AwsCliLayer');
    new CfnOutput(this, 'LayerVersionArn', { value: awscliLayer.layerVersionArn })

  }
}

const devEnv = {
  account: process.env.CDK_DEFAULT_ACCOUNT,
  region: process.env.CDK_DEFAULT_REGION,
};

const app = new App();

new MyStack(app, 'awscli-layer-stack', { env: devEnv });

app.synth();
package main

import (
	"log"
	"os"
	"strconv"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	awsSession "github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ec2"
)

const (
	instanceID = "i-0123b6c27c80108bc"
)

var (
	dryRun = getEnvBool("DRY_RUN", false)
)

func getEnvString(envVar, dfault string) string {
	value := os.Getenv(envVar)
	if value == "" {
		return dfault
	}
	return value
}

func getEnvBool(envVar string, dfault bool) bool {
	value := os.Getenv(envVar)
	if value == "" {
		return dfault
	}

	b, err := strconv.ParseBool(value)
	if err != nil {
		log.Fatalf("%s was expected to be bool", envVar)
	}
	return b
}

func handler() error {
	log.Print("Starting Factorio")

	session, err := awsSession.NewSession()
	if err != nil {
		log.Printf("Couldnt make session; err: %s", err)
		return err
	}

	ec2Service := ec2.New(session)

	input := &ec2.StartInstancesInput{}
	input.SetInstanceIds([]*string{aws.String(instanceID)}).
		SetDryRun(dryRun)

	out, err := ec2Service.StartInstances(input)
	if err != nil {
		log.Printf("Failed to start instance; err: %s", err)
		return err
	}

	for _, instance := range out.StartingInstances {
		log.Print(instance.GoString())
	}

	return nil
}

func main() {
	lambda.Start(handler)
}

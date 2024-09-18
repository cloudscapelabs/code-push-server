# Make a new release
1. Start docker `docker-compose -f docker-compose.dev.yml up -d` (needed for the tests)
2. Run `npm run release`. This will build, test, and then publish a new package version.
3. Create a `docker-build.json` file at the root of this repository.
    ```
    {
        "npmToken": "{IN PASSWORD MANAGER}",
        "repository": "{DEV ACCOUNT ID}.dkr.ecr.ap-southeast-2.amazonaws.com/csl/code-push-server"
        "repositoryProd": "{PROD ACCOUNT ID}.dkr.ecr.ap-southeast-2.amazonaws.com/csl/code-push-server"
    }
    ```
4. Run `npm run release-docker`
5. Update the image in aws cdk and deploy

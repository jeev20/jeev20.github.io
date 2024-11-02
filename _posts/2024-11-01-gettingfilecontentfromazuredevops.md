---
layout: post
title: Content of file from AzureDevops repository
date: 2024-11-01 13:56 +0100
categories: ["AzureDevops"]
tags: ["API"]
mermaid: true
published: true
---

At work this week I came across a hurdle which took me a lot of searching and asking perplexity (OpenAi) large language model for a solution. Sadly without any correct suggestions. 
In the end, I found out the solution in the [AzureDevops API documenation](https://learn.microsoft.com/en-us/rest/api/azure/devops/git/items/get?view=azure-devops-rest-7.1&tabs=HTTP)


> Case: Get content of a committed file in AzureDevops repository
{: .prompt-warning }


> TL;DR: 
> https://dev.azure.com/{organization}/{project}/_apis/git/repositories/{repositoryId}/items?path={path}&format={format}&includeContent={includeContent}&api-version=7.1
{: .prompt-tip}

## API parameters

Lets assume we have the following project details in Azure devops

Project name (project) : FileContentProject

Repository name (repositoryId) : TestRepo

File name (path): readme.json

File content (of readme.json): Raw value from https://dummyjson.com/comments


### API definition
According to [AzureDevops API documenation](https://learn.microsoft.com/en-us/rest/api/azure/devops/git/items/get?view=azure-devops-rest-7.1&tabs=HTTP) the API endpoint are as the following.
```bash
https://dev.azure.com/{organization}/{project}/_apis/git/repositories/{repositoryId}/items?path={path}&scopePath={scopePath}&recursionLevel={recursionLevel}&includeContentMetadata={includeContentMetadata}&latestProcessedChange={latestProcessedChange}&download={download}&$format={$format}&versionDescriptor.version={versionDescriptor.version}&versionDescriptor.versionOptions={versionDescriptor.versionOptions}&versionDescriptor.versionType={versionDescriptor.versionType}&includeContent={includeContent}&resolveLfs={resolveLfs}&sanitize={sanitize}&api-version=7.1
```


In my use case these were the only parameters I need to have in place. 
```bash
https://dev.azure.com/{organization}/{project}/_apis/git/repositories/{repositoryId}/items?path={path}&$format={$format}&includeContent={includeContent}&api-version=7.1
```
My API request therefore was as mentioned below (remember to update it with your organization, project and repositoryId/repository name). 
```bash
https://dev.azure.com/{myorganization}/{myproject}/_apis/git/repositories/{myrepositoryName}/items?path=readme.json&$format=json&includeContent=true&api-version=7.1
```

## Testing the API
To send a request I use [Bruno client](https://jeev20.github.io/posts/bruno/) which translates to 

### In powershell
```powershell
$headers=@{}
$headers.Add("Authorization", "Basic **t7**X0=')
$response = Invoke-RestMethod -Uri 'https://dev.azure.com/myORG/FileContentProject/_apis/git/repositories/TestRepo/items?path=readme.json&%24format=json&includeContent=true&api-version=7.1' -Method GET -Headers $headers
```
or 

### In bash
```bash
curl --request GET \
  --url 'https://dev.azure.com/myORG/FileContentProject/_apis/git/repositories/TestRepo/items?path=readme.json&%24format=json&includeContent=true&api-version=7.1' \
  --header 'Authorization: Basic **t7**X0='
```

### Result
And there it is the "content" key of the json response! 

``` plaintext
{
  "objectId": "529a003b36fb109bb7ef0ead557d4aab7a2b232b",
  "gitObjectType": "blob",
  "commitId": "e8a6d8791919ea1da0fc956540ae176af38c9264",
  "path": "/readme.json",
  "content": "{\"comments\":[{\"id\":1,\"body\":\"This is some awesome thinking!\",\"postId\":242,\"likes\":3,\"user\":{\"id\":105,\"username\":\"emmac\",\"fullName\":\"Emma Wilson\"}},{\"id\":2,\"body\":\"What terrific math skills you're showing!\",\"postId\":46,\"likes\":4,\"user\":{\"id\":183,\"username\":\"cameronp\",\"fullName\":\"Cameron Perez\"}},{\"id\":3,\"body\":\"You are an amazing writer!\",\"postId\":235,\"likes\":2,\"user\":{\"id\":1,\"username\":\"emilys\",\"fullName\":\"Emily Johnson\"}},{\"id\":4,\"body\":\"Wow! You have improved so much!\",\"postId\":31,\"likes\":1,\"user\":{\"id\":89,\"username\":\"braydenf\",\"fullName\":\"Brayden Fleming\"}},{\"id\":5,\"body\":\"Nice idea!\",\"postId\":212,\"likes\":1,\"user\":{\"id\":149,\"username\":\"wyattp\",\"fullName\":\"Wyatt Perry\"}},{\"id\":6,\"body\":\"You are showing excellent understanding!\",\"postId\":184,\"likes\":5,\"user\":{\"id\":110,\"username\":\"danielt\",\"fullName\":\"Daniel Taylor\"}},{\"id\":7,\"body\":\"This is clear, concise, and complete!\",\"postId\":172,\"likes\":1,\"user\":{\"id\":4,\"username\":\"jamesd\",\"fullName\":\"James Davis\"}},{\"id\":8,\"body\":\"What a powerful argument!\",\"postId\":233,\"likes\":0,\"user\":{\"id\":145,\"username\":\"lukec\",\"fullName\":\"Luke Cooper\"}},{\"id\":9,\"body\":\"I knew you could do it!\",\"postId\":207,\"likes\":3,\"user\":{\"id\":207,\"username\":\"jaces\",\"fullName\":\"Jace Smith\"}},{\"id\":10,\"body\":\"Wonderful ideas!\",\"postId\":87,\"likes\":0,\"user\":{\"id\":86,\"username\":\"noram\",\"fullName\":\"Nora Mills\"}},{\"id\":11,\"body\":\"It was a pleasure to grade this!\",\"postId\":156,\"likes\":8,\"user\":{\"id\":162,\"username\":\"mateob\",\"fullName\":\"Mateo Bennett\"}},{\"id\":12,\"body\":\"Keep up the incredible work!\",\"postId\":119,\"likes\":10,\"user\":{\"id\":90,\"username\":\"scarlettb\",\"fullName\":\"Scarlett Bowman\"}},{\"id\":13,\"body\":\"My goodness, how impressive!\",\"postId\":108,\"likes\":10,\"user\":{\"id\":87,\"username\":\"hunterg\",\"fullName\":\"Hunter Gordon\"}},{\"id\":14,\"body\":\"You're showing inventive ideas!\",\"postId\":20,\"likes\":8,\"user\":{\"id\":77,\"username\":\"jonathanp\",\"fullName\":\"Jonathan Pierce\"}},{\"id\":15,\"body\":\"You've shown so much growth!\",\"postId\":6,\"likes\":2,\"user\":{\"id\":17,\"username\":\"evelyns\",\"fullName\":\"Evelyn Sanchez\"}},{\"id\":16,\"body\":\"Interesting thoughts!\",\"postId\":14,\"likes\":5,\"user\":{\"id\":199,\"username\":\"viviang\",\"fullName\":\"Vivian Carter\"}},{\"id\":17,\"body\":\"I love your neat work!\",\"postId\":240,\"likes\":7,\"user\":{\"id\":155,\"username\":\"nicholase\",\"fullName\":\"Nicholas Edwards\"}},{\"id\":18,\"body\":\"Doesn't it feel good to do such great work?\",\"postId\":227,\"likes\":6,\"user\":{\"id\":134,\"username\":\"noramx\",\"fullName\":\"Nora Russell\"}},{\"id\":19,\"body\":\"First-rate work!\",\"postId\":245,\"likes\":1,\"user\":{\"id\":203,\"username\":\"novab\",\"fullName\":\"Nova Cooper\"}},{\"id\":20,\"body\":\"This is fascinating information!\",\"postId\":176,\"likes\":4,\"user\":{\"id\":39,\"username\":\"lucasg\",\"fullName\":\"Lucas Gray\"}},{\"id\":21,\"body\":\"You inspire me!\",\"postId\":229,\"likes\":0,\"user\":{\"id\":113,\"username\":\"miam\",\"fullName\":\"Mia Miller\"}},{\"id\":22,\"body\":\"This is right on target!\",\"postId\":9,\"likes\":5,\"user\":{\"id\":113,\"username\":\"miam\",\"fullName\":\"Mia Miller\"}},{\"id\":23,\"body\":\"What an astounding observation!\",\"postId\":33,\"likes\":1,\"user\":{\"id\":155,\"username\":\"nicholase\",\"fullName\":\"Nicholas Edwards\"}},{\"id\":24,\"body\":\"This is very well thought out!\",\"postId\":121,\"likes\":1,\"user\":{\"id\":169,\"username\":\"jaxonb\",\"fullName\":\"Jaxon Barnes\"}},{\"id\":25,\"body\":\"I can tell you've been practicing!\",\"postId\":247,\"likes\":9,\"user\":{\"id\":160,\"username\":\"claires\",\"fullName\":\"Claire Foster\"}},{\"id\":26,\"body\":\"You've come a long way!\",\"postId\":79,\"likes\":7,\"user\":{\"id\":59,\"username\":\"ethanf\",\"fullName\":\"Ethan Fletcher\"}},{\"id\":27,\"body\":\"I can tell you've been paying attention!\",\"postId\":55,\"likes\":9,\"user\":{\"id\":57,\"username\":\"nathand\",\"fullName\":\"Nathan Dixon\"}},{\"id\":28,\"body\":\"Reading this made my day!\",\"postId\":209,\"likes\":8,\"user\":{\"id\":177,\"username\":\"xavierw\",\"fullName\":\"Xavier Wright\"}},{\"id\":29,\"body\":\"This is very perceptive!\",\"postId\":31,\"likes\":2,\"user\":{\"id\":168,\"username\":\"lunah\",\"fullName\":\"Luna Perez\"}},{\"id\":30,\"body\":\"What an accomplishment!\",\"postId\":126,\"likes\":8,\"user\":{\"id\":89,\"username\":\"braydenf\",\"fullName\":\"Brayden Fleming\"}}],\"total\":340,\"skip\":0,\"limit\":30}",
  "url": "https://dev.azure.com/myORG/77fc686c-02b2-422a-8a90-c2cad564c113/_apis/git/repositories/df59246f-22f1-4c49-b9dc-f55f80419b15/items?path=%2Freadme.json&versionType=Branch&versionOptions=None",
  "_links": {
    "self": {
      "href": "https://dev.azure.com/myORG/77fc686c-02b2-422a-8a90-c2cad564c113/_apis/git/repositories/df59246f-22f1-4c49-b9dc-f55f80419b15/items?path=%2Freadme.json&versionType=Branch&versionOptions=None"
    },
    "repository": {
      "href": "https://dev.azure.com/myORG/77fc686c-02b2-422a-8a90-c2cad564c113/_apis/git/repositories/df59246f-22f1-4c49-b9dc-f55f80419b15"
    },
    "blob": {
      "href": "https://dev.azure.com/myORG/77fc686c-02b2-422a-8a90-c2cad564c113/_apis/git/repositories/df59246f-22f1-4c49-b9dc-f55f80419b15/blobs/529a003b36fb109bb7ef0ead557d4aab7a2b232b"
    }
  }
}
```
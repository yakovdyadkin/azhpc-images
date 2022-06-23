#!/bin/bash

####
# @Brief        : GET ADO build info
# @Param        : ADO Auth token, build url
# @RetVal       : build json
####
get_builds_res () {
    builds_json=$(curl -s -H "Authorization: Basic $SYSTEM_ACCESSTOKEN" $build_url)
    echo $builds_json
}

# Queue a build
post_build_res=$(curl -X POST "https://dev.azure.com/yakovdyadkin/webhook/_apis/build/builds?api-version=6.0" \
-H "Authorization: Basic $SYSTEM_ACCESSTOKEN" -H "Content-Type: application/json" \
--data-raw "{"definition": {"id": 1}}")

#post_build_res='{"_links":{"self":{"href":"https://dev.azure.com/yakovdyadkin/02fb2940-5e6d-4c49-9551-68993d5c0978/_apis/build/Builds/123"},"web":{"href":"https://dev.azure.com/yakovdyadkin/02fb2940-5e6d-4c49-9551-68993d5c0978/_build/results?buildId=123"},"sourceVersionDisplayUri":{"href":"https://dev.azure.com/yakovdyadkin/02fb2940-5e6d-4c49-9551-68993d5c0978/_apis/build/builds/123/sources"},"timeline":{"href":"https://dev.azure.com/yakovdyadkin/02fb2940-5e6d-4c49-9551-68993d5c0978/_apis/build/builds/123/Timeline"},"badge":{"href":"https://dev.azure.com/yakovdyadkin/02fb2940-5e6d-4c49-9551-68993d5c0978/_apis/build/status/1"}},"properties":{},"tags":[],"validationResults":[],"plans":[{"planId":"c54ebb85-b931-4701-b787-0fdd022c0810"}],"triggerInfo":{},"id":123,"buildNumber":"20220623.8","status":"notStarted","queueTime":"2022-06-23T15:33:03.5650341Z","url":"https://dev.azure.com/yakovdyadkin/02fb2940-5e6d-4c49-9551-68993d5c0978/_apis/build/Builds/123","definition":{"drafts":[],"id":1,"name":"webhook","url":"https://dev.azure.com/yakovdyadkin/02fb2940-5e6d-4c49-9551-68993d5c0978/_apis/build/Definitions/1?revision=1","uri":"vstfs:///Build/Definition/1","path":"\\","type":"build","queueStatus":"enabled","revision":1,"project":{"id":"02fb2940-5e6d-4c49-9551-68993d5c0978","name":"webhook","url":"https://dev.azure.com/yakovdyadkin/_apis/projects/02fb2940-5e6d-4c49-9551-68993d5c0978","state":"wellFormed","revision":11,"visibility":"private","lastUpdateTime":"2022-06-18T05:13:40.803Z"}},"buildNumberRevision":8,"project":{"id":"02fb2940-5e6d-4c49-9551-68993d5c0978","name":"webhook","url":"https://dev.azure.com/yakovdyadkin/_apis/projects/02fb2940-5e6d-4c49-9551-68993d5c0978","state":"wellFormed","revision":11,"visibility":"private","lastUpdateTime":"2022-06-18T05:13:40.803Z"},"uri":"vstfs:///Build/Build/123","sourceBranch":"refs/heads/master","sourceVersion":"ff097615118f771a040137435850654eb09d33a4","queue":{"id":9,"name":"Azure Pipelines","pool":{"id":9,"name":"Azure Pipelines","isHosted":true}},"priority":"normal","reason":"manual","requestedFor":{"displayName":"Yakov Dyadkin","url":"https://spsprodcus5.vssps.visualstudio.com/A15d006c2-fd50-4d44-b9d9-820a3ea4de98/_apis/Identities/69d3d039-4187-68c6-8464-57e2e8b86ff2","_links":{"avatar":{"href":"https://dev.azure.com/yakovdyadkin/_apis/GraphProfile/MemberAvatars/aad.NjlkM2QwMzktNDE4Ny03OGM2LTg0NjQtNTdlMmU4Yjg2ZmYy"}},"id":"69d3d039-4187-68c6-8464-57e2e8b86ff2","uniqueName":"yakovdyadkin@microsoft.com","imageUrl":"https://dev.azure.com/yakovdyadkin/_apis/GraphProfile/MemberAvatars/aad.NjlkM2QwMzktNDE4Ny03OGM2LTg0NjQtNTdlMmU4Yjg2ZmYy","descriptor":"aad.NjlkM2QwMzktNDE4Ny03OGM2LTg0NjQtNTdlMmU4Yjg2ZmYy"},"requestedBy":{"displayName":"Yakov Dyadkin","url":"https://spsprodcus5.vssps.visualstudio.com/A15d006c2-fd50-4d44-b9d9-820a3ea4de98/_apis/Identities/69d3d039-4187-68c6-8464-57e2e8b86ff2","_links":{"avatar":{"href":"https://dev.azure.com/yakovdyadkin/_apis/GraphProfile/MemberAvatars/aad.NjlkM2QwMzktNDE4Ny03OGM2LTg0NjQtNTdlMmU4Yjg2ZmYy"}},"id":"69d3d039-4187-68c6-8464-57e2e8b86ff2","uniqueName":"yakovdyadkin@microsoft.com","imageUrl":"https://dev.azure.com/yakovdyadkin/_apis/GraphProfile/MemberAvatars/aad.NjlkM2QwMzktNDE4Ny03OGM2LTg0NjQtNTdlMmU4Yjg2ZmYy","descriptor":"aad.NjlkM2QwMzktNDE4Ny03OGM2LTg0NjQtNTdlMmU4Yjg2ZmYy"},"lastChangedDate":"2022-06-23T15:33:03.727Z","lastChangedBy":{"displayName":"Yakov Dyadkin","url":"https://spsprodcus5.vssps.visualstudio.com/A15d006c2-fd50-4d44-b9d9-820a3ea4de98/_apis/Identities/69d3d039-4187-68c6-8464-57e2e8b86ff2","_links":{"avatar":{"href":"https://dev.azure.com/yakovdyadkin/_apis/GraphProfile/MemberAvatars/aad.NjlkM2QwMzktNDE4Ny03OGM2LTg0NjQtNTdlMmU4Yjg2ZmYy"}},"id":"69d3d039-4187-68c6-8464-57e2e8b86ff2","uniqueName":"yakovdyadkin@microsoft.com","imageUrl":"https://dev.azure.com/yakovdyadkin/_apis/GraphProfile/MemberAvatars/aad.NjlkM2QwMzktNDE4Ny03OGM2LTg0NjQtNTdlMmU4Yjg2ZmYy","descriptor":"aad.NjlkM2QwMzktNDE4Ny03OGM2LTg0NjQtNTdlMmU4Yjg2ZmYy"},"orchestrationPlan":{"planId":"c54ebb85-b931-4701-b787-0fdd022c0810"},"logs":{"id":0,"type":"Container","url":"https://dev.azure.com/yakovdyadkin/02fb2940-5e6d-4c49-9551-68993d5c0978/_apis/build/builds/123/logs"},"repository":{"id":"b013116d-3d6b-4af4-ae85-fcad152b3835","type":"TfsGit","name":"webhook","url":"https://dev.azure.com/yakovdyadkin/webhook/_git/webhook","clean":null,"checkoutSubmodules":false},"keepForever":false,"retainedByRelease":false,"triggeredByBuild":null}'

build_url=$(echo $post_build_res | jq -r "._links.self.href")
#get_builds_res=$(curl -s -H "Authorization: Basic $SYSTEM_ACCESSTOKEN" $build_url)

build_status=$(get_builds_res | jq -r ".status")

while [ $build_status != "completed" ]
do
    #get_builds_res=$(curl -s -H "Authorization: Basic $SYSTEM_ACCESSTOKEN" $build_url)
    build_status=$(get_builds_res | jq -r ".status")
  
    echo "Build status: $build_status"
    sleep 5
done

#get_builds_res=$(curl -s -H "Authorization: Basic $SYSTEM_ACCESSTOKEN" get_build_url)
build_res=$(get_builds_res | jq -r ".result")
echo "Build result: $build_res"

if [ $build_res != "succeeded" ]
then
    exit 1
fi

## PLAT-2000

```mermaid
graph LR
  US["Jira User Story: PLAT-2000"]
  TESTLOCAL["Local Testing<br>(unit + integration)"]
  US --> TESTLOCAL
  PRCRDEV["Dev PR + Review<br>branch: feature/PLAT-2000-feature → dev<br>reviewer: harrissherry@harrison-trujillo.com<br>evidence:<br>N/A"]
  TESTLOCAL --> PRCRDEV
  TESTDEV1["Dev Unit Test<br>test_id: TEST-3000<br>story_id: PLAT-2000<br>deployment_id: dev-2025-04-18T06-41-37.652049<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 106<br>failed: 0<br>coverage_percent: 92.71<br>submitted_by: cortezmary@dorsey-barker.com<br>timestamp: 2025-04-18T06:41:37.652049Z<br>evidence:<br>EV-4000<br>test_id: TEST-3000<br>coverage_percent: 92.71<br>passed: 106<br>failed: 0"]
  PRCRDEV --> TESTDEV1
  DEVDEPLOY["Deployment to DEV"]
  TESTDEV1 --> DEVDEPLOY
  TESTDEV2["Dev Integration Test<br>test_id: TEST-3001<br>story_id: PLAT-2000<br>deployment_id: dev-2025-04-18T06-41-37.652049<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 101<br>failed: 2<br>coverage_percent: 94.76<br>submitted_by: stevensanchez@vaughn-carter.com<br>timestamp: 2025-04-18T06:46:37.652049Z<br>evidence:<br>EV-4001<br>test_id: TEST-3001<br>coverage_percent: 94.76<br>passed: 101<br>failed: 2"]
  DEVDEPLOY --> TESTDEV2
  PRCRMAIN["Main PR + Review<br>branch: dev → main<br>reviewer: ortegatyler@gmail.com<br>evidence:<br>N/A"]
  TESTDEV2 --> PRCRMAIN
  TESTPREQ["PREQ Unit Test<br>test_id: TEST-3002<br>story_id: PLAT-2000<br>deployment_id: preq-2025-04-18T06-41-37.652049<br>env: preq<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 99<br>failed: 0<br>coverage_percent: 90.12<br>submitted_by: rebecca41@hotmail.com<br>timestamp: 2025-04-18T06:51:37.652049Z<br>evidence:<br>EV-4002<br>test_id: TEST-3002<br>coverage_percent: 90.12<br>passed: 99<br>failed: 0"]
  PRCRMAIN --> TESTPREQ
  PREQDEPLOY["Deployment to PREQ"]
  TESTPREQ --> PREQDEPLOY
  QADEPLOY["Deploy to QA (SNOWQA2000)<br>user_story_id: PLAT-2000<br>cr_id: SNOWQA2000<br>env: qa<br>status: approved<br>approved_by: cynthiaanderson@hotmail.com<br>approved_at: 2025-04-18T07:41:37.652049Z<br>evidence:<br>EV-4006<br>cr_id: SNOWQA2000<br>status: approved<br>approved_by: cynthiaanderson@hotmail.com<br>approved_at: 2025-04-18T07:41:37.652049Z"]
  PREQDEPLOY --> QADEPLOY
  TESTQA["QA Integration Test<br>test_id: TEST-3003<br>story_id: PLAT-2000<br>deployment_id: qa-2025-04-18T06-41-37.652049<br>env: qa<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 141<br>failed: 0<br>coverage_percent: 97.29<br>submitted_by: qvelazquez@gmail.com<br>timestamp: 2025-04-18T06:56:37.652049Z<br>evidence:<br>EV-4003<br>test_id: TEST-3003<br>coverage_percent: 97.29<br>passed: 141<br>failed: 0"]
  QADEPLOY --> TESTQA
  PRODDEPLOY["Deploy to PROD (SNOWPROD2000)<br>user_story_id: PLAT-2000<br>cr_id: SNOWPROD2000<br>env: prod<br>status: approved<br>approved_by: cosborne@yahoo.com<br>approved_at: 2025-04-18T08:41:37.652049Z<br>evidence:<br>EV-4007<br>cr_id: SNOWPROD2000<br>status: approved<br>approved_by: cosborne@yahoo.com<br>approved_at: 2025-04-18T08:41:37.652049Z"]
  TESTQA --> PRODDEPLOY
  TESTPROD["PROD Integration Test<br>test_id: TEST-3004<br>story_id: PLAT-2000<br>deployment_id: prod-2025-04-18T06-41-37.652049<br>env: prod<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 138<br>failed: 1<br>coverage_percent: 85.32<br>submitted_by: paulapoole@yahoo.com<br>timestamp: 2025-04-18T07:01:37.652049Z<br>evidence:<br>EV-4004<br>test_id: TEST-3004<br>coverage_percent: 85.32<br>passed: 138<br>failed: 1"]
  PRODDEPLOY --> TESTPROD
```

## PLAT-2001

```mermaid
graph LR
  US["Jira User Story: PLAT-2001"]
  TESTLOCAL["Local Testing<br>(unit + integration)"]
  US --> TESTLOCAL
  PRCRDEV["Dev PR + Review<br>branch: feature/PLAT-2001-feature → dev<br>reviewer: craiggarrison@fernandez.biz<br>evidence:<br>N/A"]
  TESTLOCAL --> PRCRDEV
  TESTDEV1["Dev Unit Test<br>test_id: TEST-3010<br>story_id: PLAT-2001<br>deployment_id: dev-2025-04-18T06-41-37.662605<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 131<br>failed: 1<br>coverage_percent: 92.81<br>submitted_by: xwood@evans-turner.info<br>timestamp: 2025-04-18T06:41:37.662605Z<br>evidence:<br>EV-4010<br>test_id: TEST-3010<br>coverage_percent: 92.81<br>passed: 131<br>failed: 1"]
  PRCRDEV --> TESTDEV1
  DEVDEPLOY["Deployment to DEV"]
  TESTDEV1 --> DEVDEPLOY
  TESTDEV2["Dev Integration Test<br>test_id: TEST-3011<br>story_id: PLAT-2001<br>deployment_id: dev-2025-04-18T06-41-37.662605<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 91<br>failed: 1<br>coverage_percent: 93.81<br>submitted_by: jasminepark@gmail.com<br>timestamp: 2025-04-18T06:46:37.662605Z<br>evidence:<br>EV-4011<br>test_id: TEST-3011<br>coverage_percent: 93.81<br>passed: 91<br>failed: 1"]
  DEVDEPLOY --> TESTDEV2
  PRCRMAIN["Main PR + Review<br>branch: dev → main<br>reviewer: russell49@heath-castillo.biz<br>evidence:<br>N/A"]
  TESTDEV2 --> PRCRMAIN
  TESTPREQ["PREQ Unit Test<br>test_id: TEST-3012<br>story_id: PLAT-2001<br>deployment_id: preq-2025-04-18T06-41-37.662605<br>env: preq<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 148<br>failed: 1<br>coverage_percent: 94.76<br>submitted_by: tina08@yahoo.com<br>timestamp: 2025-04-18T06:51:37.662605Z<br>evidence:<br>EV-4012<br>test_id: TEST-3012<br>coverage_percent: 94.76<br>passed: 148<br>failed: 1"]
  PRCRMAIN --> TESTPREQ
  PREQDEPLOY["Deployment to PREQ"]
  TESTPREQ --> PREQDEPLOY
  QADEPLOY["Deploy to QA (SNOWQA2001)<br>user_story_id: PLAT-2001<br>cr_id: SNOWQA2001<br>env: qa<br>status: approved<br>approved_by: scottbaker@gmail.com<br>approved_at: 2025-04-18T07:41:37.662605Z<br>evidence:<br>EV-4016<br>cr_id: SNOWQA2001<br>status: approved<br>approved_by: scottbaker@gmail.com<br>approved_at: 2025-04-18T07:41:37.662605Z"]
  PREQDEPLOY --> QADEPLOY
  TESTQA["QA Integration Test<br>test_id: TEST-3013<br>story_id: PLAT-2001<br>deployment_id: qa-2025-04-18T06-41-37.662605<br>env: qa<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 92<br>failed: 1<br>coverage_percent: 84.71<br>submitted_by: sara47@yahoo.com<br>timestamp: 2025-04-18T06:56:37.662605Z<br>evidence:<br>EV-4013<br>test_id: TEST-3013<br>coverage_percent: 84.71<br>passed: 92<br>failed: 1"]
  QADEPLOY --> TESTQA
  PRODDEPLOY["Deploy to PROD (SNOWPROD2001)<br>user_story_id: PLAT-2001<br>cr_id: SNOWPROD2001<br>env: prod<br>status: approved<br>approved_by: aherrera@martin.com<br>approved_at: 2025-04-18T08:41:37.662605Z<br>evidence:<br>EV-4017<br>cr_id: SNOWPROD2001<br>status: approved<br>approved_by: aherrera@martin.com<br>approved_at: 2025-04-18T08:41:37.662605Z"]
  TESTQA --> PRODDEPLOY
```

## PLAT-2002

```mermaid
graph LR
  US["Jira User Story: PLAT-2002"]
  TESTLOCAL["Local Testing<br>(unit + integration)"]
  US --> TESTLOCAL
  PRCRDEV["Dev PR + Review<br>branch: feature/PLAT-2002-feature → dev<br>reviewer: astark@yahoo.com<br>evidence:<br>N/A"]
  TESTLOCAL --> PRCRDEV
  TESTDEV1["Dev Unit Test<br>test_id: TEST-3020<br>story_id: PLAT-2002<br>deployment_id: dev-2025-04-18T06-41-37.670305<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 116<br>failed: 2<br>coverage_percent: 87.48<br>submitted_by: kyle16@hartman.info<br>timestamp: 2025-04-18T06:41:37.670305Z<br>evidence:<br>EV-4020<br>test_id: TEST-3020<br>coverage_percent: 87.48<br>passed: 116<br>failed: 2"]
  PRCRDEV --> TESTDEV1
  DEVDEPLOY["Deployment to DEV"]
  TESTDEV1 --> DEVDEPLOY
  TESTDEV2["Dev Integration Test<br>test_id: TEST-3021<br>story_id: PLAT-2002<br>deployment_id: dev-2025-04-18T06-41-37.670305<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 123<br>failed: 2<br>coverage_percent: 93.6<br>submitted_by: james70@burton-bush.com<br>timestamp: 2025-04-18T06:46:37.670305Z<br>evidence:<br>EV-4021<br>test_id: TEST-3021<br>coverage_percent: 93.6<br>passed: 123<br>failed: 2"]
  DEVDEPLOY --> TESTDEV2
  PRCRMAIN["Main PR + Review<br>branch: dev → main<br>reviewer: ashley50@hotmail.com<br>evidence:<br>N/A"]
  TESTDEV2 --> PRCRMAIN
  TESTPREQ["PREQ Unit Test<br>test_id: TEST-3022<br>story_id: PLAT-2002<br>deployment_id: preq-2025-04-18T06-41-37.670305<br>env: preq<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 91<br>failed: 0<br>coverage_percent: 97.33<br>submitted_by: walkerkurt@cooper.org<br>timestamp: 2025-04-18T06:51:37.670305Z<br>evidence:<br>EV-4022<br>test_id: TEST-3022<br>coverage_percent: 97.33<br>passed: 91<br>failed: 0"]
  PRCRMAIN --> TESTPREQ
  PREQDEPLOY["Deployment to PREQ"]
  TESTPREQ --> PREQDEPLOY
  QADEPLOY["Deploy to QA (SNOWQA2002)<br>user_story_id: PLAT-2002<br>cr_id: SNOWQA2002<br>env: qa<br>status: approved<br>approved_by: hawkinsrichard@yahoo.com<br>approved_at: 2025-04-18T07:41:37.670305Z<br>evidence:<br>EV-4026<br>cr_id: SNOWQA2002<br>status: approved<br>approved_by: hawkinsrichard@yahoo.com<br>approved_at: 2025-04-18T07:41:37.670305Z"]
  PREQDEPLOY --> QADEPLOY
```

## PLAT-2003

```mermaid
graph LR
  US["Jira User Story: PLAT-2003"]
  TESTLOCAL["Local Testing<br>(unit + integration)"]
  US --> TESTLOCAL
  PRCRDEV["Dev PR + Review<br>branch: feature/PLAT-2003-feature → dev<br>reviewer: davidmueller@yahoo.com<br>evidence:<br>N/A"]
  TESTLOCAL --> PRCRDEV
  TESTDEV1["Dev Unit Test<br>test_id: TEST-3030<br>story_id: PLAT-2003<br>deployment_id: dev-2025-04-18T06-41-37.676654<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 104<br>failed: 1<br>coverage_percent: 97.64<br>submitted_by: porterstacy@gmail.com<br>timestamp: 2025-04-18T06:41:37.676654Z<br>evidence:<br>EV-4030<br>test_id: TEST-3030<br>coverage_percent: 97.64<br>passed: 104<br>failed: 1"]
  PRCRDEV --> TESTDEV1
  DEVDEPLOY["Deployment to DEV"]
  TESTDEV1 --> DEVDEPLOY
  TESTDEV2["Dev Integration Test<br>test_id: TEST-3031<br>story_id: PLAT-2003<br>deployment_id: dev-2025-04-18T06-41-37.676654<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 111<br>failed: 2<br>coverage_percent: 82.17<br>submitted_by: jonathonlong@yahoo.com<br>timestamp: 2025-04-18T06:46:37.676654Z<br>evidence:<br>EV-4031<br>test_id: TEST-3031<br>coverage_percent: 82.17<br>passed: 111<br>failed: 2"]
  DEVDEPLOY --> TESTDEV2
  PRCRMAIN["Main PR + Review<br>branch: dev → main<br>reviewer: danielconner@yahoo.com<br>evidence:<br>N/A"]
  TESTDEV2 --> PRCRMAIN
  TESTPREQ["PREQ Unit Test<br>test_id: TEST-3032<br>story_id: PLAT-2003<br>deployment_id: preq-2025-04-18T06-41-37.676654<br>env: preq<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 102<br>failed: 0<br>coverage_percent: 95.67<br>submitted_by: tara06@yahoo.com<br>timestamp: 2025-04-18T06:51:37.676654Z<br>evidence:<br>EV-4032<br>test_id: TEST-3032<br>coverage_percent: 95.67<br>passed: 102<br>failed: 0"]
  PRCRMAIN --> TESTPREQ
```

## PLAT-2004

```mermaid
graph LR
  US["Jira User Story: PLAT-2004"]
  TESTLOCAL["Local Testing<br>(unit + integration)"]
  US --> TESTLOCAL
  PRCRDEV["Dev PR + Review<br>branch: feature/PLAT-2004-feature → dev<br>reviewer: andrewfranklin@gmail.com<br>evidence:<br>N/A"]
  TESTLOCAL --> PRCRDEV
  TESTDEV1["Dev Unit Test<br>test_id: TEST-3040<br>story_id: PLAT-2004<br>deployment_id: dev-2025-04-18T06-41-37.681294<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 126<br>failed: 2<br>coverage_percent: 93.96<br>submitted_by: phiggins@olson.com<br>timestamp: 2025-04-18T06:41:37.681294Z<br>evidence:<br>EV-4040<br>test_id: TEST-3040<br>coverage_percent: 93.96<br>passed: 126<br>failed: 2"]
  PRCRDEV --> TESTDEV1
  DEVDEPLOY["Deployment to DEV"]
  TESTDEV1 --> DEVDEPLOY
```

## PLAT-2005

```mermaid
graph LR
  US["Jira User Story: PLAT-2005"]
  TESTLOCAL["Local Testing<br>(unit + integration)"]
  US --> TESTLOCAL
  PRCRDEV["Dev PR + Review<br>branch: feature/PLAT-2005-feature → dev<br>reviewer: stephenchristensen@gmail.com<br>evidence:<br>N/A"]
  TESTLOCAL --> PRCRDEV
```

## PLAT-2006

```mermaid
graph LR
  US["Jira User Story: PLAT-2006"]
  TESTLOCAL["Local Testing<br>(unit + integration)"]
  US --> TESTLOCAL
  PRCRDEV["Dev PR + Review<br>branch: feature/PLAT-2006-feature → dev<br>reviewer: qlopez@hotmail.com<br>evidence:<br>N/A"]
  TESTLOCAL --> PRCRDEV
  TESTDEV1["Dev Unit Test<br>test_id: TEST-3060<br>story_id: PLAT-2006<br>deployment_id: dev-2025-04-18T06-41-37.685236<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 146<br>failed: 2<br>coverage_percent: 93.89<br>submitted_by: sergio16@armstrong.com<br>timestamp: 2025-04-18T06:41:37.685236Z<br>evidence:<br>EV-4060<br>test_id: TEST-3060<br>coverage_percent: 93.89<br>passed: 146<br>failed: 2"]
  PRCRDEV --> TESTDEV1
  DEVDEPLOY["Deployment to DEV"]
  TESTDEV1 --> DEVDEPLOY
  TESTDEV2["Dev Integration Test<br>test_id: TEST-3061<br>story_id: PLAT-2006<br>deployment_id: dev-2025-04-18T06-41-37.685236<br>env: dev<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 91<br>failed: 0<br>coverage_percent: 86.83<br>submitted_by: moraleskatherine@aguirre.com<br>timestamp: 2025-04-18T06:46:37.685236Z<br>evidence:<br>EV-4061<br>test_id: TEST-3061<br>coverage_percent: 86.83<br>passed: 91<br>failed: 0"]
  DEVDEPLOY --> TESTDEV2
  PRCRMAIN["Main PR + Review<br>branch: dev → main<br>reviewer: dustinwilliams@hotmail.com<br>evidence:<br>N/A"]
  TESTDEV2 --> PRCRMAIN
  TESTPREQ["PREQ Unit Test<br>test_id: TEST-3062<br>story_id: PLAT-2006<br>deployment_id: preq-2025-04-18T06-41-37.685236<br>env: preq<br>sprint_id: SPRINT-2025-01<br>type: unit_test<br>passed: 107<br>failed: 0<br>coverage_percent: 89.51<br>submitted_by: vzimmerman@yahoo.com<br>timestamp: 2025-04-18T06:51:37.685236Z<br>evidence:<br>EV-4062<br>test_id: TEST-3062<br>coverage_percent: 89.51<br>passed: 107<br>failed: 0"]
  PRCRMAIN --> TESTPREQ
  PREQDEPLOY["Deployment to PREQ"]
  TESTPREQ --> PREQDEPLOY
  QADEPLOY["Deploy to QA (SNOWQA2006)<br>user_story_id: PLAT-2006<br>cr_id: SNOWQA2006<br>env: qa<br>status: approved<br>approved_by: matthew22@owen.org<br>approved_at: 2025-04-18T07:41:37.685236Z<br>evidence:<br>EV-4066<br>cr_id: SNOWQA2006<br>status: approved<br>approved_by: matthew22@owen.org<br>approved_at: 2025-04-18T07:41:37.685236Z"]
  PREQDEPLOY --> QADEPLOY
  TESTQA["QA Integration Test<br>test_id: TEST-3063<br>story_id: PLAT-2006<br>deployment_id: qa-2025-04-18T06-41-37.685236<br>env: qa<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 113<br>failed: 1<br>coverage_percent: 90.68<br>submitted_by: hannah86@gmail.com<br>timestamp: 2025-04-18T06:56:37.685236Z<br>evidence:<br>EV-4063<br>test_id: TEST-3063<br>coverage_percent: 90.68<br>passed: 113<br>failed: 1"]
  QADEPLOY --> TESTQA
  PRODDEPLOY["Deploy to PROD (SNOWPROD2006)<br>user_story_id: PLAT-2006<br>cr_id: SNOWPROD2006<br>env: prod<br>status: approved<br>approved_by: johnwright@hotmail.com<br>approved_at: 2025-04-18T08:41:37.685236Z<br>evidence:<br>EV-4067<br>cr_id: SNOWPROD2006<br>status: approved<br>approved_by: johnwright@hotmail.com<br>approved_at: 2025-04-18T08:41:37.685236Z"]
  TESTQA --> PRODDEPLOY
  TESTPROD["PROD Integration Test<br>test_id: TEST-3064<br>story_id: PLAT-2006<br>deployment_id: prod-2025-04-18T06-41-37.685236<br>env: prod<br>sprint_id: SPRINT-2025-01<br>type: integration_test<br>passed: 138<br>failed: 1<br>coverage_percent: 95.35<br>submitted_by: frogers@romero.com<br>timestamp: 2025-04-18T07:01:37.685236Z<br>evidence:<br>EV-4064<br>test_id: TEST-3064<br>coverage_percent: 95.35<br>passed: 138<br>failed: 1"]
  PRODDEPLOY --> TESTPROD
```


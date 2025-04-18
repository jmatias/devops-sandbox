# Evidence Vault API Documentation

The Evidence Vault tracks SDLC activities for traceability and auditability of engineering practices.

## 📘 Evidence Vault – SDLC Traceability Example

This document illustrates the end-to-end software development lifecycle (SDLC) traceability for a canonical Jira story `PROJECT-5000`.

Each step includes metadata such as test IDs, test results, commit hashes, reviewers, ServiceNow CRs, and links to evidence blob IDs and file URLs.

## 🗂 API Endpoints

### 🧠 User Stories
- `POST /user-story` - Create a new user story (assigns sprint + release)
- `GET /user-story/{story_id}` - Get one story
- `GET /user-stories` - List all user stories
- `GET /sprint/{sprint_id}/user-stories` - List stories in a sprint
- `GET /release/{release_id}/user-stories` - List stories in a release

### 🔁 Code Reviews
- `POST /code-review` - Submit a code review
- `GET /code-review/{pr_id}` - Get review for a PR
- `GET /user-story/{story_id}/code-reviews` - Get reviews linked to a user story

### 🧪 Test Results
- `POST /test-result` - Upload test result (unit, integration, etc.)
- `GET /test-result/{test_id}` - Get one test result
- `GET /user-story/{story_id}/test-results` - Get test results for a story
- `GET /deployment/{deployment_id}/test-results` - Get tests linked to a deployment
- `GET /test-results?sprint_id=&env=` - Filter test results

### 🚀 Deployments
- `POST /deployment` - Record a deployment
- `GET /deployment/{release_id}/{env}` - Get deployments for a release/env
- `GET /user-story/{story_id}/deployments` - Get deployments involving this story
- `GET /commit/{sha}/deployments` - Trace where a commit was deployed

### 📝 Approvals (SNOW CRs)
- `POST /approval` - Save approval metadata
- `GET /approval/{cr_id}` - Get one approval
- `GET /approvals?release_id=&env=` - Filter approvals

### 📎 Evidence Blobs
- `POST /evidence` - Upload evidence
- `GET /evidence/{evidence_id}` - Get evidence details
- `GET /evidence?related_to=commit_sha|cr_id|story_id` - Query evidence by linkage

### 📦 Releases
- `POST /release` - Create new release with semantic version
- `GET /release/{release_id}` - View release metadata
- `GET /releases` - List all releases

### ⏱ Sprints
- `POST /sprint` - Create new sprint
- `GET /sprint/{sprint_id}` - Get sprint metadata
- `GET /sprints` - List all sprints
---

### 🧭 Composite Traceability Views
- `GET /traceability/story/{story_id}` - Full chain: PRs, tests, deploys, approvals
- `GET /traceability/commit/{sha}` - Track test/deploy/review for commit
- `GET /traceability/release/{release_id}` - Full release audit chain

---

## 🔁 SDLC Workflow Overview

The Evidence Vault captures artifacts at each stage of the software development lifecycle (SDLC) for traceability and audit purposes. Here’s how the domain model maps to the SDLC:

| **Stage** | **Artifact / Domain Model** | **Endpoint(s)** |
|-----------|-----------------------------|------------------|
| A Jira story is created and assigned to a sprint & release | `UserStory` | `POST /user-story` |
| Developer begins coding and creates a feature branch | (Captured in `branch_from` in `CodeReview`) | `POST /code-review` |
| Developer runs local unit & integration tests | `TestResult` | `POST /test-result` |
| PR is opened for dev → peer-reviewed and approved | `CodeReview` + `EvidenceBlob` | `POST /code-review`, `POST /evidence` |
| CI runs unit tests on merged code | `TestResult` | `POST /test-result` |
| Code is deployed to DEV environment | `Deployment` | `POST /deployment` |
| CI runs integration tests in DEV | `TestResult` | `POST /test-result` |
| PR is opened for dev → main | `CodeReview` | `POST /code-review` |
| CI runs PREQ tests post-merge | `TestResult` | `POST /test-result` |
| Code is deployed to PREQ | `Deployment` | `POST /deployment` |
| SNOW Change Request is created for QA | `Approval` | `POST /approval` |
| QA CR is approved | `Approval` + `EvidenceBlob` | `POST /approval`, `POST /evidence` |
| Code is deployed to QA | `Deployment` | `POST /deployment` |
| Integration tests run in QA | `TestResult` | `POST /test-result` |
| SNOW CR is created and approved for PROD | `Approval` + `EvidenceBlob` | `POST /approval`, `POST /evidence` |
| Code is deployed to PROD | `Deployment` | `POST /deployment` |
| Integration tests run in PROD | `TestResult` | `POST /test-result` |
| End-to-end traceability is audited | Composite of all above | `GET /traceability/story/{story_id}` |

---

## 🧱 Domain Model Schema

This section outlines the data models used in the Evidence Vault system.

<img src="docs/PLAT-2000-top-bottom.png" width="350" alt="Evidence Vault Domain Model"/>
<img src="docs/evidence_vault_domain_model.png" width="500" alt="Evidence Vault UML Diagram">

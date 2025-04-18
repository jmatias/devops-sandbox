import json
import os
from datetime import date, datetime
from typing import Dict, List, Optional

import uvicorn
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI(swagger_ui_parameters={"tryItOutEnabled": True})
STORAGE_ROOT = "./data"
os.makedirs(STORAGE_ROOT, exist_ok=True)


# Placeholder for updated endpoints based on markdown specs


@app.get("/")
def root():
    return {"message": "Evidence Vault API - Updated Version"}


# --------------------
# Helper Functions
# --------------------
def save_json(path: str, data: dict):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        json.dump(data, f, indent=2, default=str)


def load_json(path: str):
    with open(path) as f:
        return json.load(f)


def list_json_files(directory: str) -> List[dict]:
    if not os.path.exists(directory):
        return []
    return [
        load_json(os.path.join(directory, f))
        for f in os.listdir(directory)
        if f.endswith(".json") or f.endswith(".metadata.json")
    ]


# --------------------
# Domain Models
# --------------------


# Updated Models with Swagger Examples
class UserStory(BaseModel):
    model_config = {
        "json_schema_extra": {
            "example": {
                "story_id": "PLAT-1378",
                "summary": "Add user login via OAuth2",
                "sprint_id": "SPRINT-2025-01",
                "release_id": "PLAT-v4.0.3",
                "repo_refs": ["git@example.com:myorg/my-repo.git"],
            }
        }
    }
    story_id: str
    summary: str
    sprint_id: str
    release_id: str
    repo_refs: List[str]


class CodeReview(BaseModel):
    model_config = {
        "json_schema_extra": {
            "example": {
                "user_story_id": "PLAT-1378",
                "pr_id": "PR-101",
                "branch_from": "feature/PLAT-1378-oauth-login",
                "branch_to": "dev",
                "reviewer": "alice@example.com",
                "approved_at": "2025-01-12T15:32:00Z",
                "commit_sha": "abc123sha",
            }
        }
    }
    user_story_id: str
    pr_id: str
    branch_from: str
    branch_to: str
    reviewer: str
    approved_at: str
    commit_sha: str


class Deployment(BaseModel):
    model_config = {
        "json_schema_extra": {
            "example": {
                "user_story_id": "PLAT-1378",
                "release_id": "PLAT-v4.0.3",
                "env": "qa",
                "commit_sha": "abc123sha",
                "timestamp": "2025-01-13T09:45:00Z",
                "pipeline_version": "v4.0.3",
                "approval_id": "SNOW12345",
            }
        }
    }
    user_story_id: str
    release_id: str
    env: str
    commit_sha: str
    timestamp: datetime
    pipeline_version: str
    approval_id: str


class Approval(BaseModel):
    model_config = {
        "json_schema_extra": {
            "example": {
                "user_story_id": "PLAT-1378",
                "cr_id": "SNOW12345",
                "env": "qa",
                "status": "approved",
                "approved_by": "release.manager@example.com",
                "approved_at": "2025-01-13T10:15:00Z",
            }
        }
    }
    user_story_id: str
    cr_id: str
    env: str
    status: str
    approved_by: str
    approved_at: str


class TestResult(BaseModel):
    model_config = {
        "json_schema_extra": {
            "example": {
                "test_id": "TEST-001",
                "story_id": "PLAT-1378",
                "deployment_id": "qa-2025-01-13T09-45-00",
                "env": "qa",
                "sprint_id": "SPRINT-2025-01",
                "type": "unit_test",
                "passed": 120,
                "failed": 0,
                "coverage_percent": 92.5,
                "submitted_by": "qa@example.com",
                "timestamp": "2025-01-13T10:00:00Z",
                "evidence_ids": ["EV-001", "EV-002"]
            }
        }
    }
    test_id: str
    story_id: str
    deployment_id: str
    env: str
    sprint_id: str
    type: str
    passed: int
    failed: int
    coverage_percent: float
    submitted_by: str
    timestamp: datetime
    evidence_ids: Optional[List[str]] = []



class EvidenceBlob(BaseModel):
    model_config = {
        "json_schema_extra": {
            "example": {
                "evidence_id": "EV-001",
                "type": "test_report",
                "subject_type": "test_result",
                "subject_id": "TEST-001",
                "related_to": "PLAT-1378",
                "file_url": "s3://evidence-vault/PLAT-v4.0.3/SPRINT-2025-01/evidence/EV-001.test_report.json",
                "timestamp": "2025-01-13T09:46:00Z",
                "submitted_by": "jmatias@example.com",
                "metadata": {
                    "test_id": "TST-123",
                    "coverage_percent": 85.2,
                    "passed": 154,
                    "failed": 0,
                },
            }
        }
    }
    evidence_id: str
    type: str
    related_to: str
    file_url: str
    timestamp: datetime
    submitted_by: str
    subject_type: str
    subject_id: str
    metadata: Dict


class Release(BaseModel):
    model_config = {
        "json_schema_extra": {
            "example": {
                "release_id": "PLAT-v4.0.3",
                "semver": "4.0.3",
                "business_application_id": "APP-1234",
                "jira_ticket": "https://jira.example.com/browse/PLAT-v4.0.3",
                "pipeline_version": "v7.0.3",
            }
        }
    }
    release_id: str
    semver: str
    business_application_id: str
    jira_ticket: str
    pipeline_version: str


class Sprint(BaseModel):
    model_config = {
        "json_schema_extra": {
            "example": {
                "sprint_id": "SPRINT-2025-01",
                "release_id": "PLAT-v4.0.3",
                "start_date": "2025-01-01",
                "end_date": "2025-01-14",
                "quality_designation": "Compliant",
            }
        }
    }
    sprint_id: str
    release_id: str
    start_date: date
    end_date: date
    quality_designation: str


# --------------------
# Sample Endpoint
# --------------------
@app.post("/user-story")
def create_user_story(story: UserStory):
    path = os.path.join(STORAGE_ROOT, story.sprint_id, "user-stories", f"{story.story_id}.json")
    save_json(path, story.dict())
    return {"status": "created", "story_id": story.story_id}


@app.get("/user-story/{story_id}")
def get_user_story(story_id: str):
    for sprint in os.listdir(STORAGE_ROOT):
        path = os.path.join(STORAGE_ROOT, sprint, "user-stories", f"{story_id}.json")
        if os.path.exists(path):
            return load_json(path)
    raise HTTPException(status_code=404, detail="User story not found")


@app.get("/user-stories")
def list_user_stories():
    results = []
    for sprint in os.listdir(STORAGE_ROOT):
        folder = os.path.join(STORAGE_ROOT, sprint, "user-stories")
        results.extend(list_json_files(folder))
    return results


@app.get("/sprint/{sprint_id}/user-stories")
def list_stories_by_sprint(sprint_id: str):
    folder = os.path.join(STORAGE_ROOT, sprint_id, "user-stories")
    return list_json_files(folder)


@app.get("/release/{release_id}/user-stories")
def list_stories_by_release(release_id: str):
    results = []
    for sprint in os.listdir(STORAGE_ROOT):
        folder = os.path.join(STORAGE_ROOT, sprint, "user-stories")
        if os.path.exists(folder):
            for f in os.listdir(folder):
                story = load_json(os.path.join(folder, f))
                if story.get("release_id") == release_id:
                    results.append(story)
    return results


@app.post("/code-review")
def create_code_review(review: CodeReview):
    for sprint in os.listdir(STORAGE_ROOT):
        story_folder = os.path.join(STORAGE_ROOT, sprint, "user-stories")
        for f in os.listdir(story_folder):
            story = load_json(os.path.join(story_folder, f))
            if story["story_id"] == review.user_story_id:
                path = os.path.join(STORAGE_ROOT, sprint, "code-reviews", f"{review.pr_id}.json")
                save_json(path, review.dict())
                return {"status": "created", "pr_id": review.pr_id}
    raise HTTPException(status_code=404, detail="User story not found")


@app.get("/code-review/{pr_id}")
def get_code_review(pr_id: str):
    for sprint in os.listdir(STORAGE_ROOT):
        path = os.path.join(STORAGE_ROOT, sprint, "code-reviews", f"{pr_id}.json")
        if os.path.exists(path):
            return load_json(path)
    raise HTTPException(status_code=404, detail="Code review not found")


@app.get("/user-story/{story_id}/code-reviews")
def get_reviews_by_story(story_id: str):
    results = []
    for sprint in os.listdir(STORAGE_ROOT):
        folder = os.path.join(STORAGE_ROOT, sprint, "code-reviews")
        if os.path.exists(folder):
            for f in os.listdir(folder):
                r = load_json(os.path.join(folder, f))
                if r.get("user_story_id") == story_id:
                    results.append(r)
    return results


@app.post("/test-result")
def upload_test_result(result: TestResult):
    folder = os.path.join(STORAGE_ROOT, "test-results")
    path = os.path.join(folder, f"{result.test_id}.json")
    save_json(path, result.dict())
    return {"status": "created", "test_id": result.test_id}


@app.get("/test-result/{test_id}")
def get_test_result(test_id: str):
    path = os.path.join(STORAGE_ROOT, "test-results", f"{test_id}.json")
    if not os.path.exists(path):
        raise HTTPException(status_code=404, detail="Test result not found")

    result = load_json(path)

    # Inject evidence_ids based on matching subject_id
    evidence_dir = os.path.join(STORAGE_ROOT, "evidence")
    evidence_ids = []
    if os.path.exists(evidence_dir):
        for f in os.listdir(evidence_dir):
            blob = load_json(os.path.join(evidence_dir, f))
            if blob.get("subject_id") == test_id and blob.get("subject_type") == "test_result":
                evidence_ids.append(blob["evidence_id"])
    result["evidence_ids"] = evidence_ids
    return result



@app.get("/user-story/{story_id}/test-results")
def get_test_results_by_story(story_id: str):
    folder = os.path.join(STORAGE_ROOT, "test-results")
    results = []
    for f in os.listdir(folder):
        data = load_json(os.path.join(folder, f))
        if data.get("story_id") == story_id:
            results.append(data)
    return results


@app.get("/deployment/{deployment_id}/test-results")
def get_test_results_by_deployment(deployment_id: str):
    folder = os.path.join(STORAGE_ROOT, "test-results")
    results = []
    for f in os.listdir(folder):
        data = load_json(os.path.join(folder, f))
        if data.get("deployment_id") == deployment_id:
            results.append(data)
    return results


@app.get("/test-results")
def filter_test_results(sprint_id: Optional[str] = None, env: Optional[str] = None):
    folder = os.path.join(STORAGE_ROOT, "test-results")
    results = []
    for f in os.listdir(folder):
        data = load_json(os.path.join(folder, f))
        if (not sprint_id or data.get("sprint_id") == sprint_id) and (
            not env or data.get("env") == env
        ):
            results.append(data)
    return results


@app.post("/deployment")
def record_deployment(deploy: Deployment):
    folder = os.path.join(STORAGE_ROOT, deploy.release_id, "deployments")
    timestamp_str = deploy.timestamp.isoformat().replace(":", "-")
    path = os.path.join(folder, f"{deploy.env}-{timestamp_str}.json")
    save_json(path, deploy.dict())
    return {"status": "created", "deployment_id": f"{deploy.env}-{timestamp_str}"}


@app.get("/deployment/{release_id}/{env}")
def get_deployments_for_release_env(release_id: str, env: str):
    folder = os.path.join(STORAGE_ROOT, release_id, "deployments")
    return [d for d in list_json_files(folder) if d.get("env") == env]


@app.get("/user-story/{story_id}/deployments")
def get_deployments_by_story(story_id: str):
    results = []
    for release in os.listdir(STORAGE_ROOT):
        folder = os.path.join(STORAGE_ROOT, release, "deployments")
        if os.path.exists(folder):
            for f in os.listdir(folder):
                d = load_json(os.path.join(folder, f))
                if d.get("user_story_id") == story_id:
                    results.append(d)
    return results


@app.get("/commit/{sha}/deployments")
def get_deployments_by_commit(sha: str):
    results = []
    for release in os.listdir(STORAGE_ROOT):
        folder = os.path.join(STORAGE_ROOT, release, "deployments")
        if os.path.exists(folder):
            for f in os.listdir(folder):
                d = load_json(os.path.join(folder, f))
                if d.get("commit_sha") == sha:
                    results.append(d)
    return results


@app.post("/approval")
def create_approval(approval: Approval):
    path = os.path.join(STORAGE_ROOT, "approvals", f"{approval.cr_id}.json")
    save_json(path, approval.dict())
    return {"status": "created", "cr_id": approval.cr_id}


@app.get("/approval/{cr_id}")
def get_approval(cr_id: str):
    path = os.path.join(STORAGE_ROOT, "approvals", f"{cr_id}.json")
    if os.path.exists(path):
        return load_json(path)
    raise HTTPException(status_code=404, detail="Approval not found")


@app.get("/approvals")
def filter_approvals(release_id: Optional[str] = None, env: Optional[str] = None):
    folder = os.path.join(STORAGE_ROOT, "approvals")
    results = []
    for f in os.listdir(folder):
        data = load_json(os.path.join(folder, f))
        if (not release_id or data.get("user_story_id", "").startswith(release_id)) and (
            not env or data.get("env") == env
        ):
            results.append(data)
    return results


@app.post("/evidence")
def create_evidence(evidence: EvidenceBlob):
    path = os.path.join(
        STORAGE_ROOT,
        "evidence",
        f"{evidence.evidence_id}.metadata.json",
    )
    save_json(path, evidence.dict())
    return {"status": "created", "evidence_id": evidence.evidence_id}


@app.get("/evidence/{evidence_id}")
def get_evidence(evidence_id: str):
    path = os.path.join(STORAGE_ROOT, "evidence", f"{evidence_id}.metadata.json")
    if os.path.exists(path):
        return load_json(path)
    raise HTTPException(status_code=404, detail="Evidence not found")


@app.get("/evidence")
def get_evidence_by_relation(related_to: Optional[str] = None):
    folder = os.path.join(STORAGE_ROOT, "evidence")
    results = []
    for f in os.listdir(folder):
        e = load_json(os.path.join(folder, f))
        if not related_to or e.get("related_to") == related_to:
            results.append(e)
    return results

@app.post("/release")
def create_release(release: Release):
    path = os.path.join(STORAGE_ROOT, release.release_id, "release.json")
    save_json(path, release.dict())
    return {"status": "created", "release_id": release.release_id}


@app.get("/release/{release_id}")
def get_release(release_id: str):
    path = os.path.join(STORAGE_ROOT, release_id, "release.json")
    if os.path.exists(path):
        return load_json(path)
    raise HTTPException(status_code=404, detail="Release not found")


@app.get("/releases")
def list_releases():
    results = []
    for folder in os.listdir(STORAGE_ROOT):
        path = os.path.join(STORAGE_ROOT, folder, "release.json")
        if os.path.exists(path):
            results.append(load_json(path))
    return results


@app.post("/sprint")
def create_sprint(sprint: Sprint):
    path = os.path.join(STORAGE_ROOT, sprint.sprint_id, "sprint.json")
    save_json(path, sprint.dict())
    return {"status": "created", "sprint_id": sprint.sprint_id}


@app.get("/sprint/{sprint_id}")
def get_sprint(sprint_id: str):
    path = os.path.join(STORAGE_ROOT, sprint_id, "sprint.json")
    if os.path.exists(path):
        return load_json(path)
    raise HTTPException(status_code=404, detail="Sprint not found")


@app.get("/sprints")
def list_sprints():
    results = []
    for folder in os.listdir(STORAGE_ROOT):
        path = os.path.join(STORAGE_ROOT, folder, "sprint.json")
        if os.path.exists(path):
            results.append(load_json(path))
    return results


# noinspection t
@app.get("/traceability/story/{story_id}")
def traceability_story(story_id: str):
    story = None
    reviews = []
    deployments = []
    approvals = []
    test_results = []
    evidence = []

    # Load story
    for sprint in os.listdir(STORAGE_ROOT):
        story_path = os.path.join(STORAGE_ROOT, sprint, "user-stories", f"{story_id}.json")
        if os.path.exists(story_path):
            story = load_json(story_path)
            break

    if not story:
        raise HTTPException(status_code=404, detail="User story not found")

    sprint_id = story["sprint_id"]
    release_id = story["release_id"]

    # Load code reviews
    review_dir = os.path.join(STORAGE_ROOT, sprint_id, "code-reviews")
    if os.path.exists(review_dir):
        for f in os.listdir(review_dir):
            cr = load_json(os.path.join(review_dir, f))
            if cr.get("user_story_id") == story_id:
                reviews.append(cr)

    # Load deployments
    deployment_dir = os.path.join(STORAGE_ROOT, release_id, "deployments")
    if os.path.exists(deployment_dir):
        for f in os.listdir(deployment_dir):
            d = load_json(os.path.join(deployment_dir, f))
            if d.get("user_story_id") == story_id:
                deployments.append(d)

    # Load approvals
    approval_dir = os.path.join(STORAGE_ROOT, "approvals")
    if os.path.exists(approval_dir):
        for f in os.listdir(approval_dir):
            a = load_json(os.path.join(approval_dir, f))
            if a.get("user_story_id") == story_id:
                approvals.append(a)

    # Load all evidence upfront
    evidence_dir = os.path.join(STORAGE_ROOT, "evidence")
    all_evidence = []
    evidence_by_subject_id = {}
    if os.path.exists(evidence_dir):
        for f in os.listdir(evidence_dir):
            e = load_json(os.path.join(evidence_dir, f))
            all_evidence.append(e)
            sid = e.get("subject_id")
            if sid:
                evidence_by_subject_id.setdefault(sid, []).append(e)

    # Load test results and attach evidence_ids
    test_result_dir = os.path.join(STORAGE_ROOT, "test-results")
    if os.path.exists(test_result_dir):
        for f in os.listdir(test_result_dir):
            t = load_json(os.path.join(test_result_dir, f))
            if t.get("story_id") == story_id:
                t["evidence_ids"] = [e["evidence_id"] for e in evidence_by_subject_id.get(t["test_id"], [])]
                test_results.append(t)

    # Final deduped evidence list
    relevant_evidence = [
        e for e in all_evidence
        if e.get("subject_id") in {t["test_id"] for t in test_results} or
           e.get("subject_id") in {a["cr_id"] for a in approvals}
    ]

    return {
        "story": story,
        "code_reviews": reviews,
        "deployments": deployments,
        "approvals": approvals,
        "test_results": test_results,
        "evidence": relevant_evidence,
    }


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)

# Copied from here:
# https://github.blog/2024-05-02-introducing-artifact-attestations-now-in-public-beta/

package attestation.slsa1
import future.keywords.if

approved_repos := [
    # "https://github.com/sigstore/sigstore-js",
    "https://github.com/ianlewis/gha-artifact-attestations-test",
]

approved_workflow = ".github/workflows/artifact-attestations.basic.yml"

# Fail closed
default allow := false

# Allow if the repository is in the approved_repos list and the predicateType matches
allow {
    some i
    # Check if the predicateType matches the required type
    input[i].verificationResult.statement.predicateType == "https://slsa.dev/provenance/v1"

    # Attempt to safely assign the repo variable
    repo := input[i].verificationResult.statement.predicate.buildDefinition.externalParameters.workflow.repository

    repo == approved_repos[_]

    workflow_path := input[i].verificationResult.statement.predicate.buildDefinition.externalParameters.workflow.path

    workflow_path == approved_workflow
}

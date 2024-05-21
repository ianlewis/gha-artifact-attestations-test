# Copied from here:
# https://github.blog/2024-05-02-introducing-artifact-attestations-now-in-public-beta/

package attestation.slsa1
import future.keywords.if

approved_repos := [
    "https://github.com/sigstore/sigstore-js",
    "https://github.com/github/example",
]

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
}

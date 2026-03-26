#!/usr/bin/env nextflow
// hash:sha256:c46068b4f8789d0b8e595750d51182fd2713b911b8fee8ed0bb8f55ffa699560

// capsule - [Test] - capsule to add - Pipeline app panel allows run when a required param is missing
process capsule_test_capsule_to_add_pipeline_app_panel_allows_run_when_a_required_param_is_missing_1 {
	tag 'capsule-8796773'
	container "$REGISTRY_HOST/capsule/8d07812e-e0f8-4989-ab1d-6436091d5989"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=8d07812e-e0f8-4989-ab1d-6436091d5989
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8796773.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8796773.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_test_capsule_to_add_pipeline_app_panel_allows_run_when_a_required_param_is_missing_1_args}

	echo "[${task.tag}] completed!"
	"""
}

workflow {
	// run processes
	capsule_test_capsule_to_add_pipeline_app_panel_allows_run_when_a_required_param_is_missing_1()
}

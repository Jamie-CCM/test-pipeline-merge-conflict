#!/usr/bin/env nextflow
// hash:sha256:ca52487feef97e0e45e9f0ca4647bf0a7fed186f8879c18fc5d1ccce7ad57d88

// capsule - [Test] - capsule to swtich
process capsule_test_capsule_to_swtich_1 {
	tag 'capsule-8776567'
	container "$REGISTRY_HOST/capsule/3ae99841-c857-4230-bae3-70eb59b76020:7c6f02a704fc59918f0ba8b88039e825"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=3ae99841-c857-4230-bae3-70eb59b76020
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8776567.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8776567.git" capsule-repo
	fi
	git -C capsule-repo checkout 59d1d3b3f3419f7f9f4c7740a1b6473a2b86cb0e --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

workflow {
	// run processes
	capsule_test_capsule_to_swtich_1()
}

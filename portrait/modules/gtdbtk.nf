process gtdbtk_classify {
    tag "${sample_id}"

    input:
    tuple val(sample_id), path(genome_fasta)
    path(gtdbtk_data)

    output:
    path("${sample_id}", maxDepth: '2')

    script:
    """
    mkdir ${sample_id} genomes

    if [[ "${genome_fasta}" == *".gz" ]]; then
		ln -sf ../${genome_fasta} genomes/${sample_id}.fna.gz
	else
		gzip -vc ${genome_fasta} > genomes/${sample_id}.fna.gz
	fi

    gtdbtk classify_wf --mash_db ./mash.db --cpus ${task.cpus} --pplacer_cpus ${task.cpus} --genome_dir ./genomes --out_dir ${sample_id} --extension .fna.gz
    """
}

#!/bin/bash

Install_libs(){
	sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
	sudo dnf install git -y
	sudo dnf install make automake gcc gcc-c++ kernel-devel -y
	sudo dnf install python3-pip -y
	sudo pip3 install --upgrade pip
	pip3 install pandas
	pip3 install Bio
	sudo yum install java-1.8.0-openjdk -y
	sudo dnf -y install gcc-gfortran
	sudo dnf install openmpi openmpi-devel -y
	pip3 install biopython
}


Install_genomics_QC(){
	# Install FASTQC
	wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
	unzip fastqc_v0.11.9.zip
	chmod 777 FastQC/fastqc
	sudo cp FastQC/fastqc /usr/local/bin
	cd 
	sudo rm -fr FastQC fastqc_v0.11.9.zip

	# Install cutadapt
	sudo pip3 install cutadapt 

	# Install multiqc
	sudo pip3 install multiqc
}



Install_format_tools(){
	# Install samtools
	sudo dnf install samtools -y

	# Install vcftools
	sudo dnf -y install vcftools
}



Install_multiple_alignment(){
	# Install clustalw
	wget http://www.clustal.org/download/current/clustalw-2.1.tar.gz
	tar -xvf clustalw-2.1.tar.gz
	cd clustalw-2.1
	./configure
	make
	sudo make install
	cd 
	sudo rm -rf clustalw-2.1.tar.gz clustalw-2.1

	# Install muscle
	wget https://github.com/rcedgar/muscle/releases/download/v5.1/muscle5.1.linux_intel64
	chmod 777 muscle5.1.linux_intel64
	sudo mv muscle5.1.linux_intel64 /usr/local/bin/muscle


	# Install mafft
	wget https://mafft.cbrc.jp/alignment/software/mafft-7.490-gcc_fc6.x86_64.rpm
	sudo rpm -i mafft-7.490-gcc_fc6.x86_64.rpm
	cd 
	sudo rm -rf mafft-7.490-gcc_fc6.x86_64.rpm


	# Install prank
	wget http://wasabiapp.org/download/prank/prank.linux64.170427.tgz
	tar -xvf prank.linux64.170427.tgz
	sudo rm -rf $PWD/fprank/bin/lib
	sudo mv $PWD/prank/bin/prank /usr/local/bin/
	cd 
	sudo rm -rf prank prank.linux64.170427.tgz
}


Install_genome_assembly(){
	# Install Trinity
	wget https://github.com/trinityrnaseq/trinityrnaseq/releases/download/Trinity-v2.14.0/trinityrnaseq-v2.14.0.FULL.tar.gz
	sudo tar -xvf trinityrnaseq-v2.14.0.FULL.tar.gz -C /opt/
	sudo ln -s /opt/trinityrnaseq-v2.14.0/Trinity /usr/local/bin/trinity
	sudo rm -rf $PWD/trinityrnaseq-v2.14.0.FULL.tar.gz


	# install busco
	git clone https://gitlab.com/ezlab/busco.git
	cd busco/
	sudo python3 setup.py install --user
	sudo python3 setup.py install
	sudo rm -rf /home/$(whoami)/busco 
	cd
}



Install_mapping_tools(){
	# Install STAR
	wget https://github.com/alexdobin/STAR/archive/2.7.10a.tar.gz
	tar -xvf 2.7.10a.tar.gz
	cd STAR-2.7.10a/source
	make STAR
	sudo mv STAR /usr/local/bin/
	cd
	sudo rm -rf /home/$(whoami)/2.7.10a.tar.gz STAR-2.7.10a


	# Install SUBREAD
	wget https://github.com/torkian/subread-1.6.1/archive/refs/heads/master.zip
	unzip master.zip
	cd subread-1.6.1-master/src
	make -f Makefile.Linux
	cd ../bin/utilities
	mv * /usr/local/bin/
	cd ../
	sudo rm -rf utilities
	sudo mv * /usr/local/bin/
	cd 
	sudo rm -rf /home/$(whoami)/master.zip subread-1.6.1-master


	# Install HIstat2
	wget https://cloud.biohpc.swmed.edu/index.php/s/oTtGWbWjaxsQ2Ho/download
	mv download download.zip
	unzip download.zip
	cd hisat2-2.2.1
	sudo mv hisat2* /usr/local/bin/
	sudo mv extract_* /usr/local/bin/
	cd 
	sudo rm -rf download.zip  hisat2-2.2.1


	# Install TopHat
	wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.Linux_x86_64.tar.gz
	tar -xvf tophat-2.1.1.Linux_x86_64.tar.gz
	cd tophat-2.1.1.Linux_x86_64/
	rm -rf AUTHORS intervaltree LICENSE README sortedcontainers
	sudo mv * /usr/local/bin
	cd 
	sudo rm -rf tophat-2.1.1.Linux_x86_64  tophat-2.1.1.Linux_x86_64.tar.gz


	# Install BWA
	git clone https://github.com/lh3/bwa.git
	cd bwa; make
	sudo mv bwa /usr/local/bin/
	cd 
	sudo rm -rf bwa/


	# Install bowtie
	sudo dnf -y install bowtie
}




Install_RNA_analysis(){
	# Install kallisto
	wget https://github.com/pachterlab/kallisto/releases/download/v0.46.1/kallisto_linux-v0.46.1.tar.gz
	tar -xvf kallisto_linux-v0.46.1.tar.gz 
	sudo mv kallisto/kallisto /usr/local/bin
	cd 
	sudo rm -rf tophat-2.1.1.Linux_x86_64  tophat-2.1.1.Linux_x86_64.tar.gz
	sudo rm -rf kallisto kallisto_linux-v0.46.1.tar.gz 

	# Install TEtranscripts
	pip3 install TEtranscripts


	# Install HTSeq
	pip3 install HTSeq
}



Install_genomic_tool_kits(){
	# Install NCBI tool-kit
	wget https://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.13.0+-x64-linux.tar.gz
	tar -xvf ncbi-blast-2.13.0+-x64-linux.tar.gz
	cd ncbi-blast-2.13.0+/bin/
	sudo mv * /usr/local/bin/
	cd 
	sudo rm -rf ncbi*
}


Install_metagenomics(){
	# Install Mothur
	wget https://github.com/mothur/mothur/releases/download/v1.48.0/Mothur.linux_7.zip
	unzip Mothur.linux_7.zip
	cd mothur/
	rm LICENSE 
	sudo mv * /usr/local/bin
	cd 
	sudo rm -rf mothur  Mothur.linux_7.zip
}


Install_phylogenetics(){
	# Install FASTTREE
	wget wget http://meta.microbesonline.org/fasttree/FastTree.c
	gcc -DUSE_DOUBLE -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm 
	sudo mv FastTree /usr/local/bin/
	cd 
	sudo rm -rf FastTree*


	# Install PHYLIP
	wget http://evolution.gs.washington.edu/phylip/download/phylip-3.697.tar.gz
	tar -xvf phylip-3.697.tar.gz
	cd phylip-3.697/src
	mv Makefile.unx makefile
	make install
	cd ../exe/
	sudo mv * /usr/local/bin/
	cd 
	sudo rm -rf phylip-3.697  phylip-3.697.tar.gz
}



Install_libs
Install_genomics_QC
Install_format_tools
Install_multiple_alignment
Install_genome_assembly
Install_mapping_tools
Install_RNA_analysis
Install_genomic_tool_kits
Install_metagenomics
Install_phylogenetics

echo "+++++++++++++++++++ Done +++++++++++++++++++ "
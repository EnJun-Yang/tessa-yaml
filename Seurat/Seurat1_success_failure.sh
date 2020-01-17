#!/bin/bash
BUILDID="$1"
echo $BUILDID
JENKINSJOBID="$2"
ATCINPUTFOLDERPATH="$3"
VTSINPUTFOLDERPATH="$4"
SEURATOUTGCSBUCKET="gs://testinggenomic/Seurat_output"
SEURATOUTFOLDER=seurat1out-$BUILDID

if mkdir $SEURATOUTFOLDER && cd $SEURATOUTFOLDER &&  Rscript /mounttest/Taka/Scripts/Seurat1.R $ATCINPUTFOLDERPATH $VTSINPUTFOLDERPATH && ls && gsutil cp -r ../$SEURATOUTFOLDER $SEURATOUTGCSBUCKET ;
then
echo "working"
java -jar /jenkins-cli.jar -s http://10.60.2.9:8080/ -auth admin:admin build Seurat1-success-notification -p jenkinsjobID=$JENKINSJOBID -p buildid=$BUILDID -p outputgcsbucket=$SEURATOUTGCSBUCKET/$SEURATOUTFOLDER -p seuratoutfolder=$SEURATOUTFOLDER

else

echo "not working"
java -jar /jenkins-cli.jar -s http://10.60.2.9:8080/ -auth admin:admin build Seurat-failure-notification -p jenkinsjobID=$JENKINSJOBID-$BUILDID -p k8jobID=seuart1-$BUILDID

fi
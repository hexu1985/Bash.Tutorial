#!/usr/bin/env bash

idl_name="AdcuEventGroupStructure"
cdr_obj_name="adcuEventGroupStructureObjTmp"
buffer_size="ADCU_EVENT_GROUP_STRUCTURE_BUFFER_SIZE"
ptr_prefix="adcu_event_group"

infile="test.txt"
tmpfile=.${infile}.tmp
outfile="output.txt"

cp ${infile} ${tmpfile}

sed -i "s/FmmHmiOutput/${idl_name}/g" ${tmpfile}
sed -i "s/fmmHmiOutputObjTmp/${cdr_obj_name}/g" ${tmpfile}
sed -i "s/FMM_HMI_OUTPUT_BUFFER_SIZE/${buffer_size}/g" ${tmpfile}
sed -i "s/fmm_hmi_output/${ptr_prefix}/g" ${tmpfile}

mv ${tmpfile} ${outfile}


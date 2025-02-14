#!/usr/bin/env bash

idl_name="PKIResponse"
cdr_obj_name="pKIResponseObj"
prip_idx="IC_PRIP_S2M_PKI_response_topic_IDX"
buffer_size="PKI_RESPONSE_BUFFER_SIZE"
gflag_prefix="pki_response"

infile="test.txt"
tmpfile=.${infile}.tmp
outfile="output.txt"

cp ${infile} ${tmpfile}

sed -i "s/SafetyFunctionOutput/${idl_name}/g" ${tmpfile}
sed -i "s/safetyFunctionOutputObj/${cdr_obj_name}/g" ${tmpfile}
sed -i "s/SAFETY_FUNCTION_OUTPUT_BUFFER_SIZE/${buffer_size}/g" ${tmpfile}
sed -i "s/IC_PRIP_S2M_safety_function_output_IDX/${prip_idx}/g" ${tmpfile}
sed -i "s/safety_function_output/${gflag_prefix}/g" ${tmpfile}

mv ${tmpfile} ${outfile}


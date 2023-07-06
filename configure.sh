#!/bin/bash
#capture required data
namespace=$(kubectl get ns | awk 'NR==2{print $1}');
opensips_server=$(kubectl get pods -n $namespace --context kind-kind -o wide | grep opensips | awk '{print $1}');
opensips_ip=$(kubectl get pods -n $namespace --context kind-kind -o wide | grep opensips | awk '{print $6}');
uas=$(kubectl get pods -n $namespace  --context kind-kind -o wide | grep 'sipp' | awk '{print $1}');
uac=$(kubectl get pods -n $namespace  --context kind-kind -o wide | grep 'uac' | awk '{print $1}'); 
uac_ip=$(kubectl get pods -n $namespace --context kind-kind -o wide | grep 'uac' | awk '{print $6}');
uas_ip=$(kubectl get pods -n $namespace  --context kind-kind -o wide | grep 'sipp' | awk '{print $6}');

#edit opensips server pod
kubectl exec -i $opensips_server -n $namespace --context kind-kind -- bash -c "sed -i 's/172.17.0.2/$opensips_ip/g' /usr/local/opensips_proxy/etc/opensips/opensips_residential_*" ;
kubectl exec -i $opensips_server -n $namespace --context kind-kind -- bash -c "cd /usr/local/opensips_proxy/sbin/" ;
kubectl exec -i $opensips_server -n $namespace --context kind-kind -- bash -c "/etc/init.d/mysql start" ;
kubectl exec -i $opensips_server -n $namespace --context kind-kind -- bash -c "/etc/init.d/opensips start" ;

#add user
kubectl exec -i $opensips_server -n $namespace --context kind-kind -- bash -c "cd /usr/local/opensips_proxy/sbin/ && ./opensipsctl ul add chetan sip:chetan@$uas_ip:5080" ;
kubectl exec -i $opensips_server -n $namespace --context kind-kind -- bash -c "/etc/init.d/opensips restart" ;
kubectl exec -i $opensips_server -n $namespace --context kind-kind -- bash -c " echo 'successsful'" ;

#edit uas pod
kubectl exec -i $uas -n $namespace --context kind-kind -- bash -c "sed -i -e 's/172.21.112.222/$uac_ip/g' /home/sipp/sipp-3.4.1/uas_mod_orig.xml" ;

#edit uac pod
kubectl exec -i $uac -n $namespace --context kind-kind -- bash -c "sed -i -e 's/172.16.0.10/$uas_ip/g' /home/sipp/sipp-3.4.1/uac_mod.xml" ;

#start uas
#kubectl exec -it $uas -n $namespace --context kind-kind -- bash -c "export TERM=xterm"; 
kubectl exec -i $uas -n $namespace --context kind-kind -- bash -c "export TERM=xterm && ./sipp -sf uas_mod_orig.xml -rsa $opensips_ip:5060 -i $uas_ip -p 5080 > /dev/null 2>&1 &" ;
#kubectl exec -i $uas -n $namespace --context kind-kind -- bash -c "echo $?" ;

#start uac
#kubectl exec -it $uac -n $namespace --context kind-kind -- bash -c "export TERM=xterm" ;
kubectl exec -i $uac -n $namespace --context kind-kind -- bash -c "export TERM=xterm && ./sipp -sf uac_mod.xml $opensips_ip:5060 -s chetan -i $uac_ip -p 5065  -m 50 -r 100 -rp 2000 " ;
#kubectl exec -i $uac -n $namespace --context kind-kind -- bash -c "echo $?" ;

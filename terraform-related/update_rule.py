import os
import json

def remove_rule(security_group_id,rule):
    os.system('''
        aws ec2 revoke-security-group-ingress \
            --group-id {0}  \
            --ip-permissions IpProtocol={1},FromPort={2},ToPort={3},IpRanges=[{{CidrIp={4}}}]
        '''.format(security_group_id,rule['IpProtocol'],rule['FromPort'],rule['ToPort'],rule['CidrIpv4']))

def add_rule(security_group_id,rule,prefix_list_id):
    os.system('''
        aws ec2 authorize-security-group-ingress \
            --group-id {0}  \
            --ip-permissions IpProtocol={1},FromPort={2},ToPort={3},PrefixListIds=[{{PrefixListId={4}}}]
        '''.format(security_group_id,rule['IpProtocol'],rule['FromPort'],rule['ToPort'],prefix_list_id))

def remove_and_update_rule(rules,security_group_id,prefix_list_id,remove_rule):
    for rule in rules:
        if rule.get('IsEgress',True) is False and rule.get('CidrIpv4') is not None:
            if remove_rule == 'y':
                remove_rule(security_group_id,rule)
            add_rule(security_group_id,rule,prefix_list_id)

def get_rules(security_group_id):
    os.system(f'''
        aws ec2 describe-security-group-rules --filters Name="group-id",Values="{security_group_id}" --query 'SecurityGroupRules[]' > rules.json
    ''')

def main():
    security_group_id = input("Enter the security group id: ")
    prefix_list_id = input("Enter the prefix list id: ")
    remove_rule = input("Do you want to remove the rule? (y/n): ").lower()

    if len(security_group_id) == 0 or len(prefix_list_id) == 0:
        print("Security group id or prefix list id is empty")
        return

    get_rules(security_group_id)

    with open("rules.json") as f:
        data = json.load(f)
        rules = data

    remove_and_update_rule(rules,security_group_id,prefix_list_id,remove_rule)

main()



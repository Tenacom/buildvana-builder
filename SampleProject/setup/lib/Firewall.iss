#ifndef _FIREWALL_INCLUDED
#define _FIREWALL_INCLUDED

[Code]
// Profile type
const
  NET_FW_PROFILE2_DOMAIN = 1;
  NET_FW_PROFILE2_PRIVATE = 2;
  NET_FW_PROFILE2_PUBLIC = 4;
  NET_FW_PROFILE2_ALL = 2147483647;

// Protocol
const
  NET_FW_IP_PROTOCOL_TCP = 6;
  NET_FW_IP_PROTOCOL_UDP = 17;
  NET_FW_IP_PROTOCOL_ICMPv4 = 1;
  NET_FW_IP_PROTOCOL_ICMPv6 = 58;

// Direction
const
  NET_FW_RULE_DIR_IN = 1;
  NET_FW_RULE_DIR_OUT = 2;

// Action
const
  NET_FW_ACTION_BLOCK = 0;
  NET_FW_ACTION_ALLOW = 1;

type
  TFirewallRuleType = (fwrtInbound, fwrtOutbound);
  TFirewallRuleTypes = set of TFirewallRuleType;

procedure Firewall__AddRule(policy: Variant; outbound: Boolean; appName: string; fileName: string);
var
  rule: Variant;
begin

  rule := CreateOleObject('HNetCfg.FwRule'); // INetFwRule: https://msdn.microsoft.com/en-us/library/windows/desktop/aa365344(v=vs.85).aspx
  rule.Action := NET_FW_ACTION_ALLOW;
  rule.ApplicationName := fileName;
  if outbound then rule.Direction := NET_FW_RULE_DIR_OUT
              else rule.Direction := NET_FW_RULE_DIR_IN;
  rule.Enabled := true;
  //rule.Grouping := '@firewallapi.dll,-23255';
  //rule.InterfaceTypes := 'All';
  //rule.Protocol := protocol; // Must be set before LocalPorts and RemotePorts
  //rule.LocalAddresses := '*';
  //rule.LocalPorts := '*';
  //rule.RemoteAddresses := '*';
  //rule.RemotePorts := '*';
  rule.Name := appName;
  rule.Profiles := NET_FW_PROFILE2_ALL;

  policy.Rules.Add(rule); // INetFWRules: https://msdn.microsoft.com/en-us/library/windows/desktop/aa365345(v=vs.85).aspx

end;

procedure Firewall__RemoveRules(policy: Variant; appName: string);
var
  rules: Variant;
  oldCount: Int64;
  newCount: Int64;
begin

  rules := policy.Rules; // INetFWRules: https://msdn.microsoft.com/en-us/library/windows/desktop/aa365345(v=vs.85).aspx
  newCount := rules.Count;
  repeat
    oldCount := newCount;
    rules.Remove(appName);
    newCount := rules.Count;
  until newCount = oldCount;

end;

procedure Firewall_SetApplicationException(ruleTypes: TFirewallRuleTypes; appName: string; fileName: string);
var
  policy: Variant;
begin
  
  policy := CreateOleObject('HNetCfg.FwPolicy2'); // INetFwPolicy2: https://msdn.microsoft.com/en-us/library/windows/desktop/aa365309(v=vs.85).aspx

  Firewall__RemoveRules(policy, appName);

  if fwrtInbound in ruleTypes then Firewall__AddRule(policy, false, appName, fileName);
  if fwrtOutbound in ruleTypes then Firewall__AddRule(policy, true, appName, fileName);

end;

procedure Firewall_RemoveException(appName: string);
var
  policy: Variant;
begin

  policy := CreateOleObject('HNetCfg.FwPolicy2');

  Firewall__RemoveRules(policy, appName);

end;

[Setup]

#endif

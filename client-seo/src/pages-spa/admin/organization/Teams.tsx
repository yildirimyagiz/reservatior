"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Users, Plus, MoreHorizontal, Edit, Trash2, Activity, UserPlus, UserMinus, Settings } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
interface Team {
  id: string;
  name: string;
  description?: string;
  orgId: string;
  leadId?: string;
  departmentId?: string;
  maxMembers?: number;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
  members: {
    id: string;
    user: {
      id: string;
      firstName: string;
      lastName: string;
      email: string;
    };
    role: string;
    joinedAt: Date;
  }[];
  organization: {
    name: string;
  };
  lead?: {
    firstName: string;
    lastName: string;
    email: string;
  };
  department?: {
    name: string;
  };
}
interface User {
  id: string;
  firstName: string;
  lastName: string;
  email: string;
  role: string;
}
export default function Teams() {
  const {
    t
  } = useTranslation();
  const [teams, setTeams] = useState<Team[]>([]);
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
  const [isMemberDialogOpen, setIsMemberDialogOpen] = useState(false);
  const [selectedTeam, setSelectedTeam] = useState<Team | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [orgFilter, setOrgFilter] = useState<string>('all');
  const {
    toast
  } = useToast();
  const [createData, setCreateData] = useState({
    name: '',
    description: '',
    orgId: '',
    leadId: '',
    departmentId: '',
    maxMembers: ''
  });
  const [editData, setEditData] = useState({
    name: '',
    description: '',
    leadId: '',
    maxMembers: ''
  });
  const [memberData, setMemberData] = useState({
    userId: '',
    role: 'MEMBER'
  });
  useEffect(() => {
    fetchTeams();
    fetchUsers();
  }, [orgFilter]);
  const fetchTeams = async () => {
    try {
      const params = new URLSearchParams();
      if (orgFilter !== 'all') params.append('orgId', orgFilter);
      const response = (await apiClient.get(`/teams?${params}`)) as {
        data: Team[];
      };
      setTeams(response.data);
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_fetch_teams"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const fetchUsers = async () => {
    try {
      const response = (await apiClient.get('/users')) as {
        data: User[];
      };
      setUsers(response.data);
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_fetch_users"),
        variant: "destructive"
      });
    }
  };
  const createTeam = async () => {
    try {
      const data = {
        ...createData,
        maxMembers: createData.maxMembers ? parseInt(createData.maxMembers) : undefined
      };
      const response = (await apiClient.post('/teams', data)) as {
        data: Team;
      };
      setTeams([...teams, response.data]);
      setIsCreateDialogOpen(false);
      setCreateData({
        name: '',
        description: '',
        orgId: '',
        leadId: '',
        departmentId: '',
        maxMembers: ''
      });
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.team_created_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_create_team"),
        variant: "destructive"
      });
    }
  };
  const updateTeam = async () => {
    if (!selectedTeam) return;
    try {
      const data = {
        ...editData,
        maxMembers: editData.maxMembers ? parseInt(editData.maxMembers) : undefined
      };
      await apiClient.put(`/teams/${selectedTeam.id}`, data);
      setTeams(teams.map(team => team.id === selectedTeam.id ? {
        ...team,
        ...data
      } : team));
      setIsEditDialogOpen(false);
      setSelectedTeam(null);
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.team_updated_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_update_team"),
        variant: "destructive"
      });
    }
  };
  const addTeamMember = async () => {
    if (!selectedTeam) return;
    try {
      await apiClient.post(`/teams/${selectedTeam.id}/members`, memberData);
      // Refresh team data
      fetchTeams();
      setIsMemberDialogOpen(false);
      setMemberData({
        userId: '',
        role: 'MEMBER'
      });
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.member_added_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_add_member"),
        variant: "destructive"
      });
    }
  };
  const removeTeamMember = async (memberId: string) => {
    if (!selectedTeam) return;
    try {
      await apiClient.delete(`/teams/${selectedTeam.id}/members/${memberId}`);
      fetchTeams();
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.member_removed_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_remove_member"),
        variant: "destructive"
      });
    }
  };
  const deleteTeam = async (teamId: string) => {
    try {
      await apiClient.delete(`/teams/${teamId}`);
      setTeams(teams.filter(team => team.id !== teamId));
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.team_deleted_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_delete_team"),
        variant: "destructive"
      });
    }
  };
  const openEditDialog = (team: Team) => {
    setSelectedTeam(team);
    setEditData({
      name: team.name,
      description: team.description || '',
      leadId: team.leadId || '',
      maxMembers: team.maxMembers?.toString() || ''
    });
    setIsEditDialogOpen(true);
  };
  const openMemberDialog = (team: Team) => {
    setSelectedTeam(team);
    setIsMemberDialogOpen(true);
  };
  const filteredTeams = teams.filter(team => {
    const matchesSearch = team.name.toLowerCase().includes(searchTerm.toLowerCase()) || team.description && team.description.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesSearch;
  });
  const totalTeams = teams.length;
  const activeTeams = teams.filter(team => team.isActive).length;
  const totalMembers = teams.reduce((acc, team) => acc + team.members.length, 0);
  const avgTeamSize = totalTeams > 0 ? Math.round(totalMembers / totalTeams) : 0;
  if (loading) {
    return <PageShell title={t("admin.organization.teams_management")}>
        <div className="flex items-center justify-center h-64">
          <Activity className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.organization.teams_management")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.total_teams")}</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalTeams}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.active_teams")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.active_teams")}</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{activeTeams}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.currently_active")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.total_members")}</CardTitle>
              <UserPlus className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-slate-600">{totalMembers}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.across_all_teams")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.avg_team_size")}</CardTitle>
              <Settings className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-slate-600">{avgTeamSize}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.members_per_team")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex justify-between items-center">
          <div className="flex gap-4">
            <div className="relative">
              <Input placeholder={t("admin.organization.search_teams")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="w-64" />
            </div>
            <Select value={orgFilter} onValueChange={setOrgFilter}>
              <SelectTrigger className="w-[150px]">
                <SelectValue placeholder={t("admin.organization.organization")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin.organization.all_organizations")}</SelectItem>
                {/* Add organization options here */}
              </SelectContent>
            </Select>
          </div>
          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="h-4 w-4 mr-2" />{t("admin.organization.create_team")}</Button>
            </DialogTrigger>
            <DialogContent className="max-w-lg">
              <DialogHeader>
                <DialogTitle>{t("admin.organization.create_new_team")}</DialogTitle>
                <DialogDescription>{t("admin.organization.set_up_a_new")}</DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid gap-2">
                  <Label htmlFor="teamName">{t("admin.organization.team_name")}</Label>
                  <Input id="teamName" value={createData.name} onChange={e => setCreateData({
                  ...createData,
                  name: e.target.value
                })} placeholder={t("admin.organization.eg_sales_team_alpha")} required />
                </div>
                <div className="grid gap-2">
                  <Label htmlFor="teamDescription">{t("admin.organization.description")}</Label>
                  <Input id="teamDescription" value={createData.description} onChange={e => setCreateData({
                  ...createData,
                  description: e.target.value
                })} placeholder={t("admin.organization.optional_team_description")} />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div className="grid gap-2">
                    <Label htmlFor="orgId">{t("admin.organization.organization")}</Label>
                    <Input id="orgId" value={createData.orgId} onChange={e => setCreateData({
                    ...createData,
                    orgId: e.target.value
                  })} placeholder={t("admin.organization.organization_id")} required />
                  </div>
                  <div className="grid gap-2">
                    <Label htmlFor="maxMembers">{t("admin.organization.max_members")}</Label>
                    <Input id="maxMembers" type="number" value={createData.maxMembers} onChange={e => setCreateData({
                    ...createData,
                    maxMembers: e.target.value
                  })} placeholder={t("admin.organization.optional_limit")} />
                  </div>
                </div>
                <div className="grid gap-2">
                  <Label htmlFor="leadId">{t("admin.organization.team_lead")}</Label>
                  <Select value={createData.leadId} onValueChange={value => setCreateData({
                  ...createData,
                  leadId: value
                })}>
                    <SelectTrigger>
                      <SelectValue placeholder={t("admin.organization.select_team_lead")} />
                    </SelectTrigger>
                    <SelectContent>
                      {users.map(user => <SelectItem key={user.id} value={user.id}>
                          {user.firstName} {user.lastName} - {user.email}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <DialogFooter>
                <Button onClick={createTeam}>{t("admin.organization.create_team")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>

        {/* Edit Team Dialog */}
        <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>{t("admin.organization.edit_team")}</DialogTitle>
              <DialogDescription>{t("admin.organization.update_team_information_and")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid gap-2">
                <Label htmlFor="editTeamName">{t("admin.organization.team_name")}</Label>
                <Input id="editTeamName" value={editData.name} onChange={e => setEditData({
                ...editData,
                name: e.target.value
              })} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="editTeamDescription">{t("admin.organization.description")}</Label>
                <Input id="editTeamDescription" value={editData.description} onChange={e => setEditData({
                ...editData,
                description: e.target.value
              })} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="editLeadId">{t("admin.organization.team_lead")}</Label>
                <Select value={editData.leadId} onValueChange={value => setEditData({
                ...editData,
                leadId: value
              })}>
                  <SelectTrigger>
                    <SelectValue placeholder={t("admin.organization.select_team_lead")} />
                  </SelectTrigger>
                  <SelectContent>
                    {users.map(user => <SelectItem key={user.id} value={user.id}>
                        {user.firstName} {user.lastName} - {user.email}
                      </SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
              <div className="grid gap-2">
                <Label htmlFor="editMaxMembers">{t("admin.organization.max_members")}</Label>
                <Input id="editMaxMembers" type="number" value={editData.maxMembers} onChange={e => setEditData({
                ...editData,
                maxMembers: e.target.value
              })} />
              </div>
            </div>
            <DialogFooter>
              <Button onClick={updateTeam}>{t("admin.organization.update_team")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Add Member Dialog */}
        <Dialog open={isMemberDialogOpen} onOpenChange={setIsMemberDialogOpen}>
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>{t("admin.organization.add_team_member")}</DialogTitle>
              <DialogDescription>{t("admin.organization.add_a_new_member")}{selectedTeam?.name}.
              </DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid gap-2">
                <Label htmlFor="memberUserId">{t("admin.organization.select_user")}</Label>
                <Select value={memberData.userId} onValueChange={value => setMemberData({
                ...memberData,
                userId: value
              })}>
                  <SelectTrigger>
                    <SelectValue placeholder={t("admin.organization.choose_a_user")} />
                  </SelectTrigger>
                  <SelectContent>
                    {users.filter(user => !selectedTeam?.members.some(member => member.user.id === user.id)).map(user => <SelectItem key={user.id} value={user.id}>
                        {user.firstName} {user.lastName} - {user.email}
                      </SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
              <div className="grid gap-2">
                <Label htmlFor="memberRole">{t("admin.organization.role_in_team")}</Label>
                <Select value={memberData.role} onValueChange={value => setMemberData({
                ...memberData,
                role: value
              })}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="LEAD">{t("admin.organization.lead")}</SelectItem>
                    <SelectItem value="MEMBER">{t("admin.organization.member")}</SelectItem>
                    <SelectItem value="VIEWER">{t("admin.organization.viewer")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <DialogFooter>
              <Button onClick={addTeamMember}>{t("admin.organization.add_member")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Teams Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.organization.teams")}</CardTitle>
            <p className="text-sm text-muted-foreground">{t("admin.organization.manage_teams_and_their")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.organization.team")}</TableHead>
                  <TableHead>{t("admin.organization.organization")}</TableHead>
                  <TableHead>{t("admin.organization.lead")}</TableHead>
                  <TableHead>{t("admin.organization.members")}</TableHead>
                  <TableHead>{t("admin.organization.created")}</TableHead>
                  <TableHead>{t("admin.organization.status")}</TableHead>
                  <TableHead className="text-right">{t("admin.organization.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredTeams.map(team => <TableRow key={team.id}>
                    <TableCell className="font-medium">
                      <div>
                        <div className="flex items-center gap-2">
                          <Users className="h-4 w-4" />
                          {team.name}
                        </div>
                        {team.description && <p className="text-xs text-muted-foreground mt-1">
                            {team.description}
                          </p>}
                      </div>
                    </TableCell>
                    <TableCell>
                      {team.organization?.name || 'Unknown'}
                    </TableCell>
                    <TableCell>
                      {team.lead ? <div>
                          <div className="font-medium text-sm">
                            {team.lead.firstName} {team.lead.lastName}
                          </div>
                          <div className="text-xs text-muted-foreground">
                            {team.lead.email}
                          </div>
                        </div> : <span className="text-muted-foreground">{t("admin.organization.no_lead_assigned")}</span>}
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <Badge variant="outline" className="text-xs">
                          {team.members.length}
                          {team.maxMembers && `/${team.maxMembers}`}
                        </Badge>
                        <Button variant="ghost" size="sm" onClick={() => openMemberDialog(team)}>
                          <UserPlus className="h-3 w-3" />
                        </Button>
                      </div>
                    </TableCell>
                    <TableCell>
                      {new Date(team.createdAt).toLocaleDateString()}
                    </TableCell>
                    <TableCell>
                      <Badge variant={team.isActive ? "default" : "secondary"} className="text-xs">
                        {team.isActive ? "Active" : "Inactive"}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuLabel>{t("admin.organization.actions")}</DropdownMenuLabel>
                          <DropdownMenuItem onClick={() => openEditDialog(team)}>
                            <Edit className="h-4 w-4 mr-2" />{t("admin.organization.edit_team")}</DropdownMenuItem>
                          <DropdownMenuItem onClick={() => openMemberDialog(team)}>
                            <UserPlus className="h-4 w-4 mr-2" />{t("admin.organization.manage_members")}</DropdownMenuItem>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem onClick={() => deleteTeam(team.id)} className="text-red-600">
                            <Trash2 className="h-4 w-4 mr-2" />{t("admin.organization.delete_team")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Team Members Management (Expandable) */}
        {selectedTeam && <Card>
            <CardHeader>
              <CardTitle>{t("admin.organization.team_members")}{selectedTeam.name}</CardTitle>
              <p className="text-sm text-muted-foreground">{t("admin.organization.current_team_members_and")}</p>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>{t("admin.organization.member")}</TableHead>
                    <TableHead>{t("admin.organization.role")}</TableHead>
                    <TableHead>{t("admin.organization.joined")}</TableHead>
                    <TableHead className="text-right">{t("admin.organization.actions")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {selectedTeam.members.map(member => <TableRow key={member.id}>
                      <TableCell>
                        <div>
                          <div className="font-medium text-sm">
                            {member.user.firstName} {member.user.lastName}
                          </div>
                          <div className="text-xs text-muted-foreground">
                            {member.user.email}
                          </div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <Badge variant="outline" className="text-xs">
                          {member.role}
                        </Badge>
                      </TableCell>
                      <TableCell>
                        {new Date(member.joinedAt).toLocaleDateString()}
                      </TableCell>
                      <TableCell className="text-right">
                        <Button variant="ghost" size="sm" onClick={() => removeTeamMember(member.id)} className="text-red-600 hover:text-red-700">
                          <UserMinus className="h-4 w-4" />
                        </Button>
                      </TableCell>
                    </TableRow>)}
                </TableBody>
              </Table>
            </CardContent>
          </Card>}
      </div>
    </PageShell>;
}
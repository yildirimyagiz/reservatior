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
import { Building, Plus, MoreHorizontal, Edit, Trash2, Activity, Users, Settings, ArrowRight } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
interface Department {
  id: string;
  name: string;
  description?: string;
  orgId: string;
  parentId?: string;
  headId?: string;
  budget?: number;
  location?: string;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
  organization: {
    name: string;
  };
  parent?: {
    name: string;
  };
  head?: {
    firstName: string;
    lastName: string;
    email: string;
  };
  children: Department[];
  teams: {
    id: string;
    name: string;
    members: any[];
  }[];
  _count?: {
    users: number;
    teams: number;
  };
}
interface User {
  id: string;
  firstName: string;
  lastName: string;
  email: string;
}
export default function Departments() {
  const {
    t
  } = useTranslation();
  const [departments, setDepartments] = useState<Department[]>([]);
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
  const [selectedDepartment, setSelectedDepartment] = useState<Department | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [orgFilter, setOrgFilter] = useState<string>('all');
  const {
    toast
  } = useToast();
  const [createData, setCreateData] = useState({
    name: '',
    description: '',
    orgId: '',
    parentId: '',
    headId: '',
    budget: '',
    location: ''
  });
  const [editData, setEditData] = useState({
    name: '',
    description: '',
    parentId: '',
    headId: '',
    budget: '',
    location: ''
  });
  useEffect(() => {
    fetchDepartments();
    fetchUsers();
  }, [orgFilter]);
  const fetchDepartments = async () => {
    try {
      const params = new URLSearchParams();
      if (orgFilter !== 'all') params.append('orgId', orgFilter);
      const response = (await apiClient.get('/departments')) as {
        data: Department[];
      };
      setDepartments(response.data);
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_fetch_departments"),
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
  const createDepartment = async () => {
    try {
      const data = {
        ...createData,
        budget: createData.budget ? parseFloat(createData.budget) : undefined
      };
      const response = (await apiClient.post('/departments', data)) as {
        data: Department;
      };
      setDepartments([...departments, response.data]);
      setIsCreateDialogOpen(false);
      setCreateData({
        name: '',
        description: '',
        orgId: '',
        parentId: '',
        headId: '',
        budget: '',
        location: ''
      });
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.department_created_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_create_department"),
        variant: "destructive"
      });
    }
  };
  const updateDepartment = async () => {
    if (!selectedDepartment) return;
    try {
      const data = {
        ...editData,
        budget: editData.budget ? parseFloat(editData.budget) : undefined
      };
      await apiClient.put(`/departments/${selectedDepartment.id}`, data);
      setDepartments(departments.map(dept => dept.id === selectedDepartment.id ? {
        ...dept,
        ...data
      } : dept));
      setIsEditDialogOpen(false);
      setSelectedDepartment(null);
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.department_updated_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_update_department"),
        variant: "destructive"
      });
    }
  };
  const deleteDepartment = async (departmentId: string) => {
    try {
      await apiClient.delete(`/departments/${departmentId}`);
      setDepartments(departments.filter(dept => dept.id !== departmentId));
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.department_deleted_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_delete_department"),
        variant: "destructive"
      });
    }
  };
  const openEditDialog = (department: Department) => {
    setSelectedDepartment(department);
    setEditData({
      name: department.name,
      description: department.description || '',
      parentId: department.parentId || '',
      headId: department.headId || '',
      budget: department.budget?.toString() || '',
      location: department.location || ''
    });
    setIsEditDialogOpen(true);
  };
  const filteredDepartments = departments.filter(department => {
    const matchesSearch = department.name.toLowerCase().includes(searchTerm.toLowerCase()) || department.description && department.description.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesSearch;
  });

  // Build hierarchy tree
  const buildHierarchy = (departments: Department[]): Department[] => {
    const deptMap = new Map<string, Department>();
    const rootDepts: Department[] = [];

    // First pass: create map
    departments.forEach(dept => {
      deptMap.set(dept.id, {
        ...dept,
        children: []
      });
    });

    // Second pass: build tree
    departments.forEach(dept => {
      const deptWithChildren = deptMap.get(dept.id)!;
      if (dept.parentId) {
        const parent = deptMap.get(dept.parentId);
        if (parent) {
          parent.children.push(deptWithChildren);
        }
      } else {
        rootDepts.push(deptWithChildren);
      }
    });
    return rootDepts;
  };
  const hierarchicalDepartments = buildHierarchy(filteredDepartments);
  const totalDepartments = departments.length;
  const activeDepartments = departments.filter(dept => dept.isActive).length;
  const rootDepartments = departments.filter(dept => !dept.parentId).length;
  const totalUsers = departments.reduce((acc, dept) => acc + (dept._count?.users || 0), 0);
  const totalTeams = departments.reduce((acc, dept) => acc + (dept._count?.teams || 0), 0);
  if (loading) {
    return <PageShell title={t("admin.organization.departments_management")}>
        <div className="flex items-center justify-center h-64">
          <Activity className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.organization.departments_management")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-5 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.total_departments")}</CardTitle>
              <Building className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalDepartments}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.organization_units")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.active_departments")}</CardTitle>
              <Building className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{activeDepartments}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.currently_active")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.root_departments")}</CardTitle>
              <ArrowRight className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-blue-600">{rootDepartments}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.toplevel_units")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.total_users")}</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-purple-600">{totalUsers}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.across_departments")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.total_teams")}</CardTitle>
              <Settings className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-orange-600">{totalTeams}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.under_departments")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex justify-between items-center">
          <div className="flex gap-4">
            <div className="relative">
              <Input placeholder={t("admin.organization.search_departments")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="w-64" />
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
                <Plus className="h-4 w-4 mr-2" />{t("admin.organization.create_department")}</Button>
            </DialogTrigger>
            <DialogContent className="max-w-lg">
              <DialogHeader>
                <DialogTitle>{t("admin.organization.create_new_department")}</DialogTitle>
                <DialogDescription>{t("admin.organization.set_up_a_new")}</DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid gap-2">
                  <Label htmlFor="deptName">{t("admin.organization.department_name")}</Label>
                  <Input id="deptName" value={createData.name} onChange={e => setCreateData({
                  ...createData,
                  name: e.target.value
                })} placeholder={t("admin.organization.eg_engineering")} required />
                </div>
                <div className="grid gap-2">
                  <Label htmlFor="deptDescription">{t("admin.organization.description")}</Label>
                  <Input id="deptDescription" value={createData.description} onChange={e => setCreateData({
                  ...createData,
                  description: e.target.value
                })} placeholder={t("admin.organization.optional_department_description")} />
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
                    <Label htmlFor="budget">{t("admin.organization.budget")}</Label>
                    <Input id="budget" type="number" step="0.01" value={createData.budget} onChange={e => setCreateData({
                    ...createData,
                    budget: e.target.value
                  })} placeholder={t("admin.organization.annual_budget")} />
                  </div>
                </div>
                <div className="grid gap-2">
                  <Label htmlFor="location">{t("admin.organization.location")}</Label>
                  <Input id="location" value={createData.location} onChange={e => setCreateData({
                  ...createData,
                  location: e.target.value
                })} placeholder={t("admin.organization.office_location")} />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div className="grid gap-2">
                    <Label htmlFor="parentId">{t("admin.organization.parent_department")}</Label>
                    <Select value={createData.parentId} onValueChange={value => setCreateData({
                    ...createData,
                    parentId: value
                  })}>
                      <SelectTrigger>
                        <SelectValue placeholder={t("admin.organization.select_parent_optional")} />
                      </SelectTrigger>
                      <SelectContent>
                        {departments.map(dept => <SelectItem key={dept.id} value={dept.id}>
                            {dept.name}
                          </SelectItem>)}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="grid gap-2">
                    <Label htmlFor="headId">{t("admin.organization.department_head")}</Label>
                    <Select value={createData.headId} onValueChange={value => setCreateData({
                    ...createData,
                    headId: value
                  })}>
                      <SelectTrigger>
                        <SelectValue placeholder={t("admin.organization.select_head")} />
                      </SelectTrigger>
                      <SelectContent>
                        {users.map(user => <SelectItem key={user.id} value={user.id}>
                            {user.firstName} {user.lastName} - {user.email}
                          </SelectItem>)}
                      </SelectContent>
                    </Select>
                  </div>
                </div>
              </div>
              <DialogFooter>
                <Button onClick={createDepartment}>{t("admin.organization.create_department")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>

        {/* Edit Department Dialog */}
        <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>{t("admin.organization.edit_department")}</DialogTitle>
              <DialogDescription>{t("admin.organization.update_department_information_and")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid gap-2">
                <Label htmlFor="editDeptName">{t("admin.organization.department_name")}</Label>
                <Input id="editDeptName" value={editData.name} onChange={e => setEditData({
                ...editData,
                name: e.target.value
              })} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="editDeptDescription">{t("admin.organization.description")}</Label>
                <Input id="editDeptDescription" value={editData.description} onChange={e => setEditData({
                ...editData,
                description: e.target.value
              })} />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="grid gap-2">
                  <Label htmlFor="editBudget">{t("admin.organization.budget")}</Label>
                  <Input id="editBudget" type="number" step="0.01" value={editData.budget} onChange={e => setEditData({
                  ...editData,
                  budget: e.target.value
                })} />
                </div>
                <div className="grid gap-2">
                  <Label htmlFor="editLocation">{t("admin.organization.location")}</Label>
                  <Input id="editLocation" value={editData.location} onChange={e => setEditData({
                  ...editData,
                  location: e.target.value
                })} />
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="grid gap-2">
                  <Label htmlFor="editParentId">{t("admin.organization.parent_department")}</Label>
                  <Select value={editData.parentId} onValueChange={value => setEditData({
                  ...editData,
                  parentId: value
                })}>
                    <SelectTrigger>
                      <SelectValue placeholder={t("admin.organization.select_parent")} />
                    </SelectTrigger>
                    <SelectContent>
                      {departments.filter(dept => dept.id !== selectedDepartment?.id).map(dept => <SelectItem key={dept.id} value={dept.id}>
                          {dept.name}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div className="grid gap-2">
                  <Label htmlFor="editHeadId">{t("admin.organization.department_head")}</Label>
                  <Select value={editData.headId} onValueChange={value => setEditData({
                  ...editData,
                  headId: value
                })}>
                    <SelectTrigger>
                      <SelectValue placeholder={t("admin.organization.select_head")} />
                    </SelectTrigger>
                    <SelectContent>
                      {users.map(user => <SelectItem key={user.id} value={user.id}>
                          {user.firstName} {user.lastName} - {user.email}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </div>
            <DialogFooter>
              <Button onClick={updateDepartment}>{t("admin.organization.update_department")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Departments Hierarchy Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.organization.department_hierarchy")}</CardTitle>
            <p className="text-sm text-muted-foreground">{t("admin.organization.organizational_structure_and_department")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.organization.department")}</TableHead>
                  <TableHead>{t("admin.organization.head")}</TableHead>
                  <TableHead>{t("admin.organization.organization")}</TableHead>
                  <TableHead>{t("admin.organization.users")}</TableHead>
                  <TableHead>{t("admin.organization.teams")}</TableHead>
                  <TableHead>{t("admin.organization.budget")}</TableHead>
                  <TableHead>{t("admin.organization.created")}</TableHead>
                  <TableHead>{t("admin.organization.status")}</TableHead>
                  <TableHead className="text-right">{t("admin.organization.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {hierarchicalDepartments.map(department => <TableRow key={department.id}>
                    <TableCell className="font-medium">
                      <div className="flex items-center gap-2">
                        <Building className="h-4 w-4" />
                        <div>
                          <div className="flex items-center gap-1">
                            {department.name}
                            {department.parent && <span className="text-xs text-muted-foreground">{t("admin.organization.under")}{department.parent.name})
                              </span>}
                          </div>
                          {department.description && <p className="text-xs text-muted-foreground mt-1">
                              {department.description}
                            </p>}
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      {department.head ? <div>
                          <div className="font-medium text-sm">
                            {department.head.firstName} {department.head.lastName}
                          </div>
                          <div className="text-xs text-muted-foreground">
                            {department.head.email}
                          </div>
                        </div> : <span className="text-muted-foreground">{t("admin.organization.no_head_assigned")}</span>}
                    </TableCell>
                    <TableCell>
                      {department.organization?.name || 'Unknown'}
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline" className="text-xs">
                        {department._count?.users || 0}{t("admin.organization.users")}</Badge>
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline" className="text-xs">
                        {department._count?.teams || 0}{t("admin.organization.teams")}</Badge>
                    </TableCell>
                    <TableCell>
                      {department.budget ? <span className="font-medium">
                          ${department.budget.toLocaleString()}
                        </span> : <span className="text-muted-foreground">-</span>}
                    </TableCell>
                    <TableCell>
                      {new Date(department.createdAt).toLocaleDateString()}
                    </TableCell>
                    <TableCell>
                      <Badge variant={department.isActive ? "default" : "secondary"} className="text-xs">
                        {department.isActive ? "Active" : "Inactive"}
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
                          <DropdownMenuItem onClick={() => openEditDialog(department)}>
                            <Edit className="h-4 w-4 mr-2" />{t("admin.organization.edit_department")}</DropdownMenuItem>
                          <DropdownMenuItem>
                            <Users className="h-4 w-4 mr-2" />{t("admin.organization.view_users")}</DropdownMenuItem>
                          <DropdownMenuItem>
                            <Settings className="h-4 w-4 mr-2" />{t("admin.organization.manage_teams")}</DropdownMenuItem>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem onClick={() => deleteDepartment(department.id)} className="text-red-600">
                            <Trash2 className="h-4 w-4 mr-2" />{t("admin.organization.delete_department")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Department Statistics */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("admin.organization.hierarchy_levels")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.root_level")}</span>
                  <span className="font-medium">{rootDepartments}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.subdepartments")}</span>
                  <span className="font-medium">{totalDepartments - rootDepartments}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.max_depth")}</span>
                  <span className="font-medium">{t("admin.organization.3_levels")}</span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin.organization.resource_allocation")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="text-center">
                  <div className="text-2xl font-bold text-green-600">
                    {totalUsers}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin.organization.total_users")}</p>
                  <div className="text-xs text-muted-foreground mt-1">
                    {totalDepartments > 0 ? Math.round(totalUsers / totalDepartments) : 0}{t("admin.organization.avg_per_department")}</div>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-blue-600">
                    {totalTeams}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin.organization.total_teams")}</p>
                  <div className="text-xs text-muted-foreground mt-1">
                    {totalDepartments > 0 ? Math.round(totalTeams / totalDepartments) : 0}{t("admin.organization.avg_per_department")}</div>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin.organization.budget_overview")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.departments_with_budget")}</span>
                  <span className="font-medium">
                    {departments.filter(d => d.budget).length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.total_budget")}</span>
                  <span className="font-medium">
                    ${departments.reduce((acc, d) => acc + (d.budget || 0), 0).toLocaleString()}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.average_budget")}</span>
                  <span className="font-medium">
                    ${departments.length > 0 ? Math.round(departments.reduce((acc, d) => acc + (d.budget || 0), 0) / departments.length).toLocaleString() : '0'}
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </PageShell>;
}
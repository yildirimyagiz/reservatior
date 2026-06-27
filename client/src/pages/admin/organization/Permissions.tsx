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
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Shield, Plus, MoreHorizontal, Edit, Trash2, Activity, Users, Settings } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
interface Permission {
  id: string;
  key: string;
  name: string;
  description?: string;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
  roles: {
    id: string;
    name: string;
    key: string;
  }[];
}
export default function Permissions() {
  const {
    t
  } = useTranslation();
  const [permissions, setPermissions] = useState<Permission[]>([]);
  const [loading, setLoading] = useState(true);
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
  const [selectedPermission, setSelectedPermission] = useState<Permission | null>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const {
    toast
  } = useToast();
  const [createData, setCreateData] = useState({
    key: '',
    name: '',
    description: ''
  });
  const [editData, setEditData] = useState({
    name: '',
    description: ''
  });
  useEffect(() => {
    fetchPermissions();
  }, []);
  const fetchPermissions = async () => {
    try {
      const response = (await apiClient.get('/permission')) as {
        data: Permission[];
      };
      setPermissions(response.data);
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_fetch_permissions"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const createPermission = async () => {
    try {
      const response = (await apiClient.post('/permission', createData)) as {
        data: Permission;
      };
      setPermissions([...permissions, response.data]);
      setIsCreateDialogOpen(false);
      setCreateData({
        key: '',
        name: '',
        description: ''
      });
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.permission_created_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_create_permission"),
        variant: "destructive"
      });
    }
  };
  const updatePermission = async () => {
    if (!selectedPermission) return;
    try {
      await apiClient.put(`/permission/${selectedPermission.id}`, editData);
      setPermissions(permissions.map(perm => perm.id === selectedPermission.id ? {
        ...perm,
        ...editData
      } : perm));
      setIsEditDialogOpen(false);
      setSelectedPermission(null);
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.permission_updated_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_update_permission"),
        variant: "destructive"
      });
    }
  };
  const deletePermission = async (permissionId: string) => {
    try {
      await apiClient.delete(`/permission/${permissionId}`);
      setPermissions(permissions.filter(perm => perm.id !== permissionId));
      toast({
        title: t("admin.organization.success"),
        description: t("admin.organization.permission_deleted_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.organization.error"),
        description: t("admin.organization.failed_to_delete_permission"),
        variant: "destructive"
      });
    }
  };
  const openEditDialog = (permission: Permission) => {
    setSelectedPermission(permission);
    setEditData({
      name: permission.name,
      description: permission.description || ''
    });
    setIsEditDialogOpen(true);
  };
  const filteredPermissions = permissions.filter(permission => {
    const matchesSearch = permission.name.toLowerCase().includes(searchTerm.toLowerCase()) || permission.key.toLowerCase().includes(searchTerm.toLowerCase()) || permission.description && permission.description.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesSearch;
  });
  const totalPermissions = permissions.length;
  const activePermissions = permissions.filter(perm => !perm.deletedAt).length;
  const usedPermissions = permissions.filter(perm => perm.roles.length > 0).length;
  const unusedPermissions = permissions.filter(perm => perm.roles.length === 0).length;
  if (loading) {
    return <PageShell title={t("admin.organization.permissions_management")}>
        <div className="flex items-center justify-center h-64">
          <Activity className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.organization.permissions_management")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.total_permissions")}</CardTitle>
              <Shield className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalPermissions}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.system_permissions")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.active_permissions")}</CardTitle>
              <Shield className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{activePermissions}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.not_deleted")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.used_permissions")}</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-blue-600">{usedPermissions}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.assigned_to_roles")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.organization.unused_permissions")}</CardTitle>
              <Settings className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-orange-600">{unusedPermissions}</div>
              <p className="text-xs text-muted-foreground">{t("admin.organization.not_assigned")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex justify-between items-center">
          <div className="flex gap-4">
            <div className="relative">
              <Input placeholder={t("admin.organization.search_permissions")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="w-64" />
            </div>
          </div>
          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
              <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
                <DialogTrigger asChild>
                  <Button>
                    <Plus className="h-4 w-4 mr-2" />{t("admin.organization.create_permission")}</Button>
                </DialogTrigger>
                <DialogContent className="max-w-lg">
                  <DialogHeader>
                    <DialogTitle>{t("admin.organization.create_new_permission")}</DialogTitle>
                    <DialogDescription>{t("admin.organization.define_a_new_system")}</DialogDescription>
                  </DialogHeader>
                  <div className="grid gap-4 py-4">
                    <div className="grid gap-2">
                      <Label htmlFor="permissionKey">{t("admin.organization.permission_key")}</Label>
                      <Input id="permissionKey" value={createData.key} onChange={e => setCreateData({
                      ...createData,
                      key: e.target.value
                    })} placeholder={t("admin.organization.eg_propertycreate")} required />
                    </div>
                    <div className="grid gap-2">
                      <Label htmlFor="permissionName">{t("admin.organization.display_name")}</Label>
                      <Input id="permissionName" value={createData.name} onChange={e => setCreateData({
                      ...createData,
                      name: e.target.value
                    })} placeholder={t("admin.organization.eg_create_property")} required />
                    </div>
                    <div className="grid gap-2">
                      <Label htmlFor="permissionDescription">{t("admin.organization.description")}</Label>
                      <Input id="permissionDescription" value={createData.description} onChange={e => setCreateData({
                      ...createData,
                      description: e.target.value
                    })} placeholder={t("admin.organization.optional_description_of_the")} />
                    </div>
                  </div>
                  <DialogFooter>
                    <Button onClick={createPermission}>{t("admin.organization.create_permission")}</Button>
                  </DialogFooter>
                </DialogContent>
              </Dialog>
            </Dialog>
          </Dialog>
        </div>

        {/* Edit Permission Dialog */}
        <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>{t("admin.organization.edit_permission")}</DialogTitle>
              <DialogDescription>{t("admin.organization.update_permission_details")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid gap-2">
                <Label htmlFor="editPermissionName">{t("admin.organization.display_name")}</Label>
                <Input id="editPermissionName" value={editData.name} onChange={e => setEditData({
                ...editData,
                name: e.target.value
              })} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="editPermissionDescription">{t("admin.organization.description")}</Label>
                <Input id="editPermissionDescription" value={editData.description} onChange={e => setEditData({
                ...editData,
                description: e.target.value
              })} />
              </div>
            </div>
            <DialogFooter>
              <Button onClick={updatePermission}>{t("admin.organization.update_permission")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Permissions Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.organization.permissions")}</CardTitle>
            <p className="text-sm text-muted-foreground">{t("admin.organization.system_permissions_and_their")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.organization.permission")}</TableHead>
                  <TableHead>{t("admin.organization.key")}</TableHead>
                  <TableHead>{t("admin.organization.description")}</TableHead>
                  <TableHead>{t("admin.organization.assigned_roles")}</TableHead>
                  <TableHead>{t("admin.organization.created")}</TableHead>
                  <TableHead>{t("admin.organization.status")}</TableHead>
                  <TableHead className="text-right">{t("admin.organization.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredPermissions.map(permission => <TableRow key={permission.id}>
                    <TableCell className="font-medium">
                      <div className="flex items-center gap-2">
                        <Shield className="h-4 w-4" />
                        {permission.name}
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline" className="text-xs font-mono">
                        {permission.key}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <p className="text-sm text-muted-foreground">
                        {permission.description || 'No description'}
                      </p>
                    </TableCell>
                    <TableCell>
                      <div className="flex flex-wrap gap-1">
                        {permission.roles.slice(0, 2).map(role => <Badge key={role.id} variant="secondary" className="text-xs">
                            {role.name}
                          </Badge>)}
                        {permission.roles.length > 2 && <Badge variant="secondary" className="text-xs">
                            +{permission.roles.length - 2}{t("admin.organization.more")}</Badge>}
                      </div>
                    </TableCell>
                    <TableCell>
                      {new Date(permission.createdAt).toLocaleDateString()}
                    </TableCell>
                    <TableCell>
                      {permission.deletedAt ? <Badge variant="destructive" className="text-xs">{t("admin.organization.deleted")}</Badge> : <Badge variant="default" className="text-xs">{t("admin.organization.active")}</Badge>}
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
                          <DropdownMenuItem onClick={() => openEditDialog(permission)}>
                            <Edit className="h-4 w-4 mr-2" />{t("admin.organization.edit_permission")}</DropdownMenuItem>
                          <DropdownMenuItem>
                            <Users className="h-4 w-4 mr-2" />{t("admin.organization.view_role_assignments")}</DropdownMenuItem>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem onClick={() => deletePermission(permission.id)} className="text-red-600">
                            <Trash2 className="h-4 w-4 mr-2" />{t("admin.organization.delete_permission")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Permission Usage Stats */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("admin.organization.permission_categories")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.property_permissions")}</span>
                  <span className="font-medium">
                    {permissions.filter(p => p.key.includes('PROPERTY')).length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.user_permissions")}</span>
                  <span className="font-medium">
                    {permissions.filter(p => p.key.includes('USER')).length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.organization_permissions")}</span>
                  <span className="font-medium">
                    {permissions.filter(p => p.key.includes('ORG')).length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.financial_permissions")}</span>
                  <span className="font-medium">
                    {permissions.filter(p => p.key.includes('FINANCE') || p.key.includes('PAYMENT')).length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.organization.admin_permissions")}</span>
                  <span className="font-medium">
                    {permissions.filter(p => p.key.includes('ADMIN')).length}
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin.organization.assignment_statistics")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="text-center">
                  <div className="text-2xl font-bold text-blue-600">
                    {permissions.reduce((acc, perm) => acc + perm.roles.length, 0)}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin.organization.total_assignments")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-green-600">
                    {usedPermissions}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin.organization.used_permissions")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-orange-600">
                    {unusedPermissions}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin.organization.unused_permissions")}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </PageShell>;
}
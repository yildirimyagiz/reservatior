import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect, useMemo } from "react";
import { motion } from "framer-motion";
import { useToast } from "@/hooks/use-toast";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { User, Plus, Search, Mail, Phone, Edit, Trash2, MoreHorizontal, Download, Upload, Loader2 } from "lucide-react";
import { contactsApi, Contact, ContactCreate, ContactUpdate } from "@/lib/api/contacts";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
const CONTACT_TYPES = [{
  value: "LEAD",
  label: t("client.src.lead"),
  color: "bg-blue-100 text-blue-800"
}, {
  value: "CLIENT",
  label: t("client.src.client"),
  color: "bg-green-100 text-green-800"
}, {
  value: "TENANT",
  label: t("client.src.tenant"),
  color: "bg-purple-100 text-purple-800"
}, {
  value: "LANDLORD",
  label: t("client.src.landlord"),
  color: "bg-orange-100 text-orange-800"
}, {
  value: "AGENT",
  label: t("client.src.agent"),
  color: "bg-indigo-100 text-indigo-800"
}, {
  value: "VENDOR",
  label: t("client.src.vendor"),
  color: "bg-gray-100 text-gray-800"
}];
const CONTACT_STATUS = [{
  value: "ACTIVE",
  label: t("client.src.active"),
  color: "bg-green-100 text-green-800"
}, {
  value: "INACTIVE",
  label: t("client.src.inactive"),
  color: "bg-gray-100 text-gray-800"
}, {
  value: "PROSPECT",
  label: t("client.src.prospect"),
  color: "bg-yellow-100 text-yellow-800"
}, {
  value: "LOST",
  label: t("client.src.lost"),
  color: "bg-red-100 text-red-800"
}];
export default function Contacts() {
  const {
    t
  } = useTranslation();
  const queryClient = useQueryClient();
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedContact, setSelectedContact] = useState<Contact | null>(null);
  const [formData, setFormData] = useState<ContactCreate>({
    orgId: "",
    firstName: "",
    lastName: "",
    email: "",
    contactType: "LEAD",
    status: "ACTIVE"
  });
  const { toast } = useToast();

  const { data: rawContacts = [], isLoading } = useQuery({
    queryKey: ['contacts'],
    queryFn: async () => {
      const response = await contactsApi.getAll() as unknown as { data: Contact[] };
      return response.data || [];
    }
  });

  const contacts = rawContacts;
  // Filter contacts
  const filteredContacts = useMemo(() => {
    return contacts.filter(contact => {
      const matchesSearch = searchTerm === "" || contact.firstName.toLowerCase().includes(searchTerm.toLowerCase()) || contact.lastName.toLowerCase().includes(searchTerm.toLowerCase()) || contact.email.toLowerCase().includes(searchTerm.toLowerCase()) || contact.company?.toLowerCase().includes(searchTerm.toLowerCase());
      const matchesType = filterType === "all" || contact.contactType === filterType;
      const matchesStatus = filterStatus === "all" || contact.status === filterStatus;
      return matchesSearch && matchesType && matchesStatus;
    });
  }, [contacts, searchTerm, filterType, filterStatus]);

  const createMutation = useMutation({
    mutationFn: (data: ContactCreate) => contactsApi.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['contacts'] });
      toast({ title: t("client.src.success"), description: t("client.src.contact_created_successfully") });
      setCreateOpen(false);
      resetForm();
    },
    onError: () => {
      toast({ title: t("client.src.error"), description: t("client.src.failed_to_save_contact"), variant: "destructive" });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: ContactUpdate }) => contactsApi.update(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['contacts'] });
      toast({ title: t("client.src.success"), description: t("client.src.contact_updated_successfully") });
      setEditOpen(false);
      resetForm();
    },
    onError: () => {
      toast({ title: t("client.src.error"), description: t("client.src.failed_to_save_contact"), variant: "destructive" });
    }
  });

  // Handle create/update
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (selectedContact) {
      updateMutation.mutate({ id: selectedContact.id, data: formData as ContactUpdate });
    } else {
      createMutation.mutate(formData);
    }
  };

  const deleteMutation = useMutation({
    mutationFn: (id: string) => contactsApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['contacts'] });
      toast({ title: t("client.src.success"), description: t("client.src.contact_deleted_successfully") });
    },
    onError: () => {
      toast({ title: t("client.src.error"), description: t("client.src.failed_to_delete_contact"), variant: "destructive" });
    }
  });

  // Handle delete
  const handleDelete = (id: string) => {
    deleteMutation.mutate(id);
  };

  // Reset form
  const resetForm = () => {
    setFormData({
      orgId: "",
      firstName: "",
      lastName: "",
      email: "",
      contactType: "LEAD",
      status: "ACTIVE"
    });
    setSelectedContact(null);
  };

  // Handle edit
  const handleEdit = (contact: Contact) => {
    setSelectedContact(contact);
    setFormData({
      orgId: contact.orgId,
      firstName: contact.firstName,
      lastName: contact.lastName,
      email: contact.email,
      phone: contact.phone,
      mobile: contact.mobile,
      company: contact.company,
      position: contact.position,
      contactType: contact.contactType,
      status: contact.status,
      tags: contact.tags,
      notes: contact.notes
    });
    setEditOpen(true);
  };

  // Get contact type styling
  const getContactTypeStyle = (type: string) => {
    return CONTACT_TYPES.find(t => t.value === type)?.color || "bg-gray-100 text-gray-800";
  };

  // Get status styling
  const getStatusStyle = (status: string) => {
    return CONTACT_STATUS.find(s => s.value === status)?.color || "bg-gray-100 text-gray-800";
  };
  return <div className="p-6">
        <div className="mb-8">
          <h1 className="text-2xl font-bold text-gray-900">{t("client.src.contacts")}</h1>
          <p className="text-gray-600 mt-1">{t("client.src.manage_your_contacts_and")}</p>
        </div>

        <div className="flex items-center space-x-4 mb-8">
          <Button variant="outline" size="sm">
            <Upload className="w-4 h-4 mr-2" />{t("client.src.import")}</Button>
          <Button variant="outline" size="sm">
            <Download className="w-4 h-4 mr-2" />{t("client.src.export")}</Button>
          <Button onClick={() => setCreateOpen(true)}>
            <Plus className="w-4 h-4 mr-2" />{t("client.src.add_contact")}</Button>
        </div>

        {/* Filters */}
        <div className="bg-white border-b border-gray-200 px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex flex-col sm:flex-row gap-4">
            <div className="flex-1">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-4 h-4" />
                <Input placeholder={t("client.src.search_contacts")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-10" />
              </div>
            </div>
            <Select value={filterType} onValueChange={setFilterType}>
              <SelectTrigger className="w-full sm:w-48">
                <SelectValue placeholder={t("client.src.filter_by_type")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_types")}</SelectItem>
                {CONTACT_TYPES.map(type => <SelectItem key={type.value} value={type.value}>
                    {type.label}
                  </SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-full sm:w-48">
                <SelectValue placeholder={t("client.src.filter_by_status")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_statuses")}</SelectItem>
                {CONTACT_STATUS.map(status => <SelectItem key={status.value} value={status.value}>
                    {status.label}
                  </SelectItem>)}
              </SelectContent>
            </Select>
          </div>
        </div>

        {/* Main Content */}
        <div className="px-4 sm:px-6 lg:px-8 py-8">
          {isLoading ? <div className="flex items-center justify-center h-64">
              <Loader2 className="w-12 h-12 animate-spin text-blue-600" />
            </div> : <motion.div initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        duration: 0.5
      }}>
              <Card>
                <CardContent className="p-0">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>{t("client.src.name")}</TableHead>
                        <TableHead>{t("client.src.contact_info")}</TableHead>
                        <TableHead>{t("client.src.type")}</TableHead>
                        <TableHead>{t("client.src.status")}</TableHead>
                        <TableHead>{t("client.src.company")}</TableHead>
                        <TableHead>{t("client.src.last_contact")}</TableHead>
                        <TableHead className="text-right">{t("client.src.actions")}</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {filteredContacts.map(contact => <TableRow key={contact.id}>
                          <TableCell>
                            <div className="flex items-center">
                              <div className="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center">
                                <User className="w-5 h-5 text-blue-600" />
                              </div>
                              <div className="ml-4">
                                <div className="text-sm font-medium text-gray-900">
                                  {contact.firstName} {contact.lastName}
                                </div>
                                {contact.position && <div className="text-sm text-gray-500">
                                    {contact.position}
                                  </div>}
                              </div>
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="space-y-1">
                              <div className="flex items-center text-sm text-gray-900">
                                <Mail className="w-4 h-4 mr-2 text-gray-400" />
                                {contact.email}
                              </div>
                              {contact.phone && <div className="flex items-center text-sm text-gray-500">
                                  <Phone className="w-4 h-4 mr-2 text-gray-400" />
                                  {contact.phone}
                                </div>}
                            </div>
                          </TableCell>
                          <TableCell>
                            <Badge className={getContactTypeStyle(contact.contactType)}>
                              {CONTACT_TYPES.find(t => t.value === contact.contactType)?.label}
                            </Badge>
                          </TableCell>
                          <TableCell>
                            <Badge className={getStatusStyle(contact.status)}>
                              {CONTACT_STATUS.find(s => s.value === contact.status)?.label}
                            </Badge>
                          </TableCell>
                          <TableCell>
                            <div className="text-sm text-gray-900">
                              {contact.company || "-"}
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="text-sm text-gray-500">
                              {contact.lastContactDate ? new Date(contact.lastContactDate).toLocaleDateString() : "Never"}
                            </div>
                          </TableCell>
                          <TableCell className="text-right">
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <Button variant="ghost" size="sm">
                                  <MoreHorizontal className="w-4 h-4" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent align="end">
                                <DropdownMenuItem onClick={() => handleEdit(contact)}>
                                  <Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                                <DropdownMenuItem onClick={() => handleDelete(contact.id)} className="text-red-600">
                                  <Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </TableCell>
                        </TableRow>)}
                    </TableBody>
                  </Table>
                </CardContent>
              </Card>
            </motion.div>}
        </div>

        {/* Create/Edit Dialog */}
        <Dialog open={createOpen || editOpen} onOpenChange={editOpen ? setEditOpen : setCreateOpen}>
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader>
              <DialogTitle>
                {selectedContact ? "Edit Contact" : "Create Contact"}
              </DialogTitle>
              <DialogDescription>
                {selectedContact ? "Update the contact information below." : "Fill in the contact information below."}
              </DialogDescription>
            </DialogHeader>
            <form onSubmit={handleSubmit}>
              <div className="grid grid-cols-2 gap-4 py-4">
                <div className="space-y-2">
                  <Label htmlFor="firstName">{t("client.src.first_name")}</Label>
                  <Input id="firstName" value={formData.firstName} onChange={e => setFormData({
                ...formData,
                firstName: e.target.value
              })} required />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="lastName">{t("client.src.last_name")}</Label>
                  <Input id="lastName" value={formData.lastName} onChange={e => setFormData({
                ...formData,
                lastName: e.target.value
              })} required />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="email">{t("client.src.email")}</Label>
                  <Input id="email" type="email" value={formData.email} onChange={e => setFormData({
                ...formData,
                email: e.target.value
              })} required />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="phone">{t("client.src.phone")}</Label>
                  <Input id="phone" value={formData.phone || ""} onChange={e => setFormData({
                ...formData,
                phone: e.target.value
              })} />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="company">{t("client.src.company")}</Label>
                  <Input id="company" value={formData.company || ""} onChange={e => setFormData({
                ...formData,
                company: e.target.value
              })} />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="position">{t("client.src.position")}</Label>
                  <Input id="position" value={formData.position || ""} onChange={e => setFormData({
                ...formData,
                position: e.target.value
              })} />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="contactType">{t("client.src.contact_type")}</Label>
                  <Select value={formData.contactType} onValueChange={value => setFormData({
                ...formData,
                contactType: value
              })}>
                    <SelectTrigger>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      {CONTACT_TYPES.map(type => <SelectItem key={type.value} value={type.value}>
                          {type.label}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label htmlFor="status">{t("client.src.status")}</Label>
                  <Select value={formData.status} onValueChange={value => setFormData({
                ...formData,
                status: value
              })}>
                    <SelectTrigger>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      {CONTACT_STATUS.map(status => <SelectItem key={status.value} value={status.value}>
                          {status.label}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div className="col-span-2 space-y-2">
                  <Label htmlFor="notes">{t("client.src.notes")}</Label>
                  <Textarea id="notes" value={formData.notes || ""} onChange={e => setFormData({
                ...formData,
                notes: e.target.value
              })} rows={3} />
                </div>
              </div>
              <DialogFooter>
                <Button type="button" variant="outline" onClick={() => {
              setCreateOpen(false);
              setEditOpen(false);
              resetForm();
            }}>{t("client.src.cancel")}</Button>
                <Button type="submit">
                  {selectedContact ? "Update" : "Create"}
                </Button>
              </DialogFooter>
            </form>
          </DialogContent>
        </Dialog>
      </div>;
}
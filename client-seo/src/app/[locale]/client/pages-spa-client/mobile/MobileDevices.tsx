"use client";

import { useTranslation } from "react-i18next";
import React, { useState, useEffect } from "react";
import { mobileDevicesApi, MobileDevice, MobileDeviceCreate } from "@/lib/api/mobile-devices";
type MobileDevicesPageProps = object
const MobileDevicesPage: React.FC<MobileDevicesPageProps> = () => {
  const {
    t
  } = useTranslation();
  const [devices, setDevices] = useState<MobileDevice[]>([]);
  const [loading, setLoading] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingDevice, setEditingDevice] = useState<MobileDevice | null>(null);
  const [formData, setFormData] = useState<MobileDeviceCreate>({
    userId: "",
    deviceId: "",
    platform: "",
    isActive: true
  });
  useEffect(() => {
    loadDevices();
  }, []);
  const loadDevices = async () => {
    try {
      setLoading(true);
      const response = await mobileDevicesApi.getAll();
      setDevices((response as any).data || []);
    } catch (error) {
      console.error("Failed to load mobile devices:", error);
    } finally {
      setLoading(false);
    }
  };
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      if (editingDevice) {
        await mobileDevicesApi.update(editingDevice.id, formData);
      } else {
        await mobileDevicesApi.create(formData);
      }
      await loadDevices();
      setIsModalOpen(false);
      setEditingDevice(null);
      setFormData({
        userId: "",
        deviceId: "",
        platform: "",
        isActive: true
      });
    } catch (error) {
      console.error("Failed to save device:", error);
    }
  };
  const handleEdit = (device: MobileDevice) => {
    setEditingDevice(device);
    setFormData({
      userId: device.userId,
      deviceId: device.deviceId,
      platform: device.platform,
      isActive: device.isActive
    });
    setIsModalOpen(true);
  };
  const handleDelete = async (deviceId: string) => {
    if (window.confirm("Are you sure you want to delete this device?")) {
      try {
        await mobileDevicesApi.delete(deviceId);
        await loadDevices();
      } catch (error) {
        console.error("Failed to delete device:", error);
      }
    }
  };
  const sendPushNotification = async (deviceId: string) => {
    const title = prompt("Enter notification title:");
    const message = prompt("Enter notification message:");
    if (title && message) {
      try {
        await mobileDevicesApi.sendPushNotification(deviceId, {
          title,
          message
        });
        console.log("Push notification sent successfully!");
      } catch (error) {
        console.error("Failed to send push notification:", error);
        console.error("Failed to send push notification");
      }
    }
  };
  if (loading) {
    return <div className="flex items-center justify-center h-64">
        <div className="text-lg">{t("client.src.loading_mobile_devices")}</div>
      </div>;
  }
  return <div className="p-6">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">{t("client.src.mobile_devices_management")}</h1>
        <button onClick={() => setIsModalOpen(true)} className="bg-brand/100 text-white px-4 py-2 rounded hover:bg-brand">{t("client.src.add_device")}</button>
      </div>

      <div className="bg-card rounded-lg shadow overflow-hidden">
        <table className="min-w-full">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 tracking-wider">{t("client.src.device")}</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 tracking-wider">{t("common.platform")}</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 tracking-wider">{t("client.src.user")}</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 tracking-wider">{t("common.status")}</th>
              <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 tracking-wider">{t("common.actions")}</th>
            </tr>
          </thead>
          <tbody className="bg-card divide-y divide-gray-200">
            {devices.map(device => <tr key={device.id}>
                <td className="px-6 py-4 whitespace-nowrap">
                  <div className="text-sm font-medium text-gray-900">
                    {device.deviceId}
                  </div>
                  <div className="text-sm text-gray-500">
                    {device.model}
                  </div>
                </td>
                <td className="px-6 py-4 whitespace-nowrap">
                  <div className="text-sm text-gray-900">
                    {device.platform}
                  </div>
                  <div className="text-sm text-gray-500">
                    {device.osVersion}
                  </div>
                </td>
                <td className="px-6 py-4 whitespace-nowrap">
                  <div className="text-sm text-gray-900">
                    {device.user?.name || device.user?.email}
                  </div>
                </td>
                <td className="px-6 py-4 whitespace-nowrap">
                  <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${device.isActive ? 'bg-blue-100 text-blue-800' : 'bg-red-100 text-red-800'}`}>
                    {device.isActive ? 'Active' : 'Inactive'}
                  </span>
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                  {device.isActive && <button onClick={() => sendPushNotification(device.id)} className="text-brand hover:text-brand mr-2">{t("client.src.send_push")}</button>}
                  <button onClick={() => handleEdit(device)} className="text-brand hover:text-brand mr-2">{t("common.edit")}</button>
                  <button onClick={() => handleDelete(device.id)} className="text-red-600 hover:text-red-900">{t("common.delete")}</button>
                </td>
              </tr>)}
          </tbody>
        </table>
      </div>

      {isModalOpen && <div className="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
          <div className="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-card">
            <h2 className="text-lg font-bold text-gray-900 mb-4">
              {editingDevice ? "Edit Device" : "Add New Device"}
            </h2>
            <form onSubmit={handleSubmit}>
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">{t("client.src.user_id")}</label>
                <input type="text" required aria-label="User ID" value={formData.userId} onChange={e => setFormData({
              ...formData,
              userId: e.target.value
            })} className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" />
              </div>
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">{t("client.src.device_id")}</label>
                <input type="text" required aria-label="Device ID" value={formData.deviceId} onChange={e => setFormData({
              ...formData,
              deviceId: e.target.value
            })} className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" />
              </div>
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">{t("common.platform")}</label>
                <select aria-label="Platform" value={formData.platform} onChange={e => setFormData({
              ...formData,
              platform: e.target.value
            })} className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                  <option value="">{t("client.src.select_platform")}</option>
                  <option value="ios">{t("client.src.ios")}</option>
                  <option value="android">{t("client.src.android")}</option>
                  <option value="web">{t("client.src.web")}</option>
                </select>
              </div>
              <div className="mb-4">
                <label className="flex items-center">
                  <input type="checkbox" checked={formData.isActive} onChange={e => setFormData({
                ...formData,
                isActive: e.target.checked
              })} className="mr-2" />
                  <span className="text-sm font-medium text-gray-700">{t("common.active")}</span>
                </label>
              </div>
              <div className="flex justify-end space-x-3">
                <button type="button" onClick={() => {
              setIsModalOpen(false);
              setEditingDevice(null);
              setFormData({
                userId: "",
                deviceId: "",
                platform: "",
                isActive: true
              });
            }} className="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 border border-gray-300 rounded-md hover:bg-gray-200">{t("common.cancel")}</button>
                <button type="submit" className="px-4 py-2 text-sm font-medium text-white bg-brand/100 border border-transparent rounded-md hover:bg-brand">
                  {editingDevice ? "Update" : "Create"}
                </button>
              </div>
            </form>
          </div>
        </div>}
    </div>;
};
export default MobileDevicesPage;
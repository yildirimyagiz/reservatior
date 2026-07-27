"use client";

import { useState, useCallback } from "react";
import { Upload, FileSpreadsheet, CheckCircle, AlertTriangle, X, Download, Loader2 } from "lucide-react";

interface BulkUploadEngineProps {
  onUploadComplete?: (batchId: string) => void;
  corporateAccountId: string;
}

export default function BulkUploadEngine({ onUploadComplete, corporateAccountId }: BulkUploadEngineProps) {
  const [dragActive, setDragActive] = useState(false);
  const [files, setFiles] = useState<File[]>([]);
  const [uploading, setUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState(0);
  const [uploadStatus, setUploadStatus] = useState<"idle" | "success" | "error">("idle");
  const [errorMessage, setErrorMessage] = useState<string>("");
  const [uploadedBatchId, setUploadedBatchId] = useState<string>("");

  const handleDrag = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.type === "dragenter" || e.type === "dragover") {
      setDragActive(true);
    } else if (e.type === "dragleave") {
      setDragActive(false);
    }
  }, []);

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setDragActive(false);
    
    if (e.dataTransfer.files && e.dataTransfer.files[0]) {
      const droppedFiles = Array.from(e.dataTransfer.files);
      handleFiles(droppedFiles);
    }
  }, []);

  const handleFiles = (newFiles: File[]) => {
    const validFiles = newFiles.filter(file => {
      const validTypes = [
        'text/csv',
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'application/json'
      ];
      const validExtensions = ['.csv', '.xlsx', '.xls', '.json'];
      const fileExtension = '.' + file.name.split('.').pop()?.toLowerCase();
      return validTypes.includes(file.type) || validExtensions.includes(fileExtension);
    });

    if (validFiles.length === 0) {
      setErrorMessage("Please upload CSV, Excel, or JSON files only");
      setUploadStatus("error");
      return;
    }

    setFiles(prev => [...prev, ...validFiles]);
    setUploadStatus("idle");
    setErrorMessage("");
  };

  const handleFileInput = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      handleFiles(Array.from(e.target.files));
    }
  };

  const removeFile = (index: number) => {
    setFiles(prev => prev.filter((_, i) => i !== index));
  };

  const handleUpload = async () => {
    if (files.length === 0) return;

    setUploading(true);
    setUploadProgress(0);
    setUploadStatus("idle");

    try {
      const formData = new FormData();
      files.forEach(file => {
        formData.append('files', file);
      });
      formData.append('corporateAccountId', corporateAccountId);
      formData.append('batchType', 'bulk_import');

      // Simulate upload progress
      const progressInterval = setInterval(() => {
        setUploadProgress(prev => {
          if (prev >= 90) {
            clearInterval(progressInterval);
            return 90;
          }
          return prev + 10;
        });
      }, 200);

      const response = await fetch('/api/v1/b2b/portfolio-batches/upload', {
        method: 'POST',
        body: formData,
      });

      clearInterval(progressInterval);
      setUploadProgress(100);

      if (!response.ok) {
        throw new Error('Upload failed');
      }

      const result = await response.json();
      setUploadedBatchId(result.id);
      setUploadStatus("success");
      setFiles([]);
      
      if (onUploadComplete) {
        onUploadComplete(result.id);
      }
    } catch (error) {
      setUploadStatus("error");
      setErrorMessage("Failed to upload files. Please try again.");
    } finally {
      setUploading(false);
    }
  };

  const downloadTemplate = () => {
    // Create a CSV template
    const template = [
      ["Property Name", "Address", "City", "State", "Zip", "Property Type", "Bedrooms", "Bathrooms", "Square Feet", "Monthly Rent", "Furnished", "Amenities"],
      ["Example Property", "123 Main St", "Seattle", "WA", "98101", "Apartment", "2", "2", "1200", "2500", "Yes", "Gym, Pool, Parking"],
    ];
    
    const csvContent = template.map(row => row.join(',')).join('\n');
    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'property_import_template.csv';
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="space-y-6">
      {/* Upload Area */}
      <div
        className={`relative border-2 border-dashed rounded-xl p-12 text-center transition-all ${
          dragActive
            ? "border-blue-500 bg-blue-50"
            : "border-gray-300 bg-gray-50 hover:border-gray-400"
        }`}
        onDragEnter={handleDrag}
        onDragLeave={handleDrag}
        onDragOver={handleDrag}
        onDrop={handleDrop}
      >
        <input
          type="file"
          multiple
          accept=".csv,.xlsx,.xls,.json"
          onChange={handleFileInput}
          className="absolute inset-0 w-full h-full opacity-0 cursor-pointer"
          disabled={uploading}
        />
        
        <div className="flex flex-col items-center">
          <div className={`w-16 h-16 rounded-full flex items-center justify-center mb-4 ${
            dragActive ? "bg-blue-100" : "bg-gray-200"
          }`}>
            <Upload className={`w-8 h-8 ${dragActive ? "text-blue-600" : "text-gray-500"}`} />
          </div>
          <p className="text-lg font-medium text-gray-900 mb-2">
            Drag and drop your files here
          </p>
          <p className="text-sm text-gray-600 mb-4">
            or click to browse
          </p>
          <p className="text-xs text-gray-500">
            Supports CSV, Excel (.xlsx, .xls), and JSON files
          </p>
        </div>
      </div>

      {/* File List */}
      {files.length > 0 && (
        <div className="space-y-3">
          <h3 className="font-medium text-gray-900">Selected Files</h3>
          {files.map((file, index) => (
            <div
              key={index}
              className="flex items-center justify-between p-4 bg-white border border-gray-200 rounded-lg"
            >
              <div className="flex items-center gap-3">
                <FileSpreadsheet className="w-5 h-5 text-green-600" />
                <div>
                  <p className="font-medium text-gray-900">{file.name}</p>
                  <p className="text-sm text-gray-600">{(file.size / 1024).toFixed(2)} KB</p>
                </div>
              </div>
              <button
                onClick={() => removeFile(index)}
                disabled={uploading}
                className="p-2 hover:bg-gray-100 rounded-lg text-gray-500 hover:text-red-600 disabled:opacity-50"
              >
                <X className="w-4 h-4" />
              </button>
            </div>
          ))}
        </div>
      )}

      {/* Upload Progress */}
      {uploading && (
        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <span className="text-sm font-medium text-gray-900">Uploading...</span>
            <span className="text-sm text-gray-600">{uploadProgress}%</span>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-2">
            <div
              className="bg-blue-600 h-2 rounded-full transition-all duration-300"
              style={{ width: `${uploadProgress}%` }}
            />
          </div>
        </div>
      )}

      {/* Status Messages */}
      {uploadStatus === "success" && (
        <div className="flex items-center gap-3 p-4 bg-green-50 border border-green-200 rounded-lg">
          <CheckCircle className="w-5 h-5 text-green-600" />
          <div>
            <p className="font-medium text-green-900">Upload Successful</p>
            <p className="text-sm text-green-700">Your portfolio is being processed. You can track progress in the dashboard.</p>
          </div>
        </div>
      )}

      {uploadStatus === "error" && (
        <div className="flex items-center gap-3 p-4 bg-red-50 border border-red-200 rounded-lg">
          <AlertTriangle className="w-5 h-5 text-red-600" />
          <div>
            <p className="font-medium text-red-900">Upload Failed</p>
            <p className="text-sm text-red-700">{errorMessage}</p>
          </div>
        </div>
      )}

      {/* Action Buttons */}
      <div className="flex gap-3">
        <button
          onClick={downloadTemplate}
          className="flex-1 px-4 py-3 border border-gray-300 rounded-lg hover:bg-gray-50 transition flex items-center justify-center gap-2"
        >
          <Download className="w-4 h-4" />
          Download Template
        </button>
        <button
          onClick={handleUpload}
          disabled={files.length === 0 || uploading}
          className="flex-1 px-4 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
        >
          {uploading ? (
            <>
              <Loader2 className="w-4 h-4 animate-spin" />
              Uploading...
            </>
          ) : (
            <>
              <Upload className="w-4 h-4" />
              Upload Portfolio
            </>
          )}
        </button>
      </div>

      {/* Upload Guidelines */}
      <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
        <h4 className="font-medium text-blue-900 mb-2">Upload Guidelines</h4>
        <ul className="text-sm text-blue-800 space-y-1">
          <li>• Maximum file size: 50MB per file</li>
          <li>• Maximum rows per file: 10,000 properties</li>
          <li>• Required columns: Property Name, Address, City, State, Zip</li>
          <li>• Supported property types: Studio, 1BR, 2BR, 3BR, Penthouse</li>
          <li>• Furnishing status: Furnished, Unfurnished, Partially Furnished</li>
        </ul>
      </div>
    </div>
  );
}

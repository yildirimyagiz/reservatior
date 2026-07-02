 "use client"
 import { useTranslation } from "react-i18next";
import React, { Component, ErrorInfo, ReactNode } from 'react';
import { AlertTriangle, RefreshCw, Home } from 'lucide-react';
import { Button } from './button';
import { Card, CardContent, CardHeader, CardTitle } from './card';
interface Props {
  children: ReactNode;
  fallback?: ReactNode;
  onError?: (error: Error, errorInfo: ErrorInfo) => void;
}
interface State {
  hasError: boolean;
  error: Error | null;
  errorInfo: ErrorInfo | null;
}
const isDevelopment = true; // Simple flag for development mode

const ErrorBoundaryFallback = ({ error, errorInfo, onReset, onGoHome }: any) => {
  const { t } = useTranslation();
  return <div className="min-h-screen flex items-center justify-center p-4">
    <Card className="w-full max-w-lg">
      <CardHeader className="text-center">
        <div className="mx-auto w-12 h-12 bg-destructive/10 rounded-full flex items-center justify-center mb-4">
          <AlertTriangle className="w-6 h-6 text-destructive" />
        </div>
        <CardTitle className="text-xl">{t("client.src.something_went_wrong")}</CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <p className="text-center text-muted-foreground">{t("client.src.were_sorry_but_something")}</p>
        
        {isDevelopment && error && <div className="bg-muted rounded-lg p-4">
            <h4 className="font-medium mb-2">{t("client.src.error_details")}</h4>
            <p className="text-sm text-destructive font-mono break-all">
              {error.message}
            </p>
            {errorInfo && <details className="mt-2">
                <summary className="text-sm cursor-pointer">{t("client.src.component_stack")}</summary>
                <pre className="text-xs mt-2 whitespace-pre-wrap">
                  {errorInfo.componentStack}
                </pre>
              </details>}
          </div>}

        <div className="flex gap-2">
          <Button onClick={onReset} className="flex-1">
            <RefreshCw className="w-4 h-4 mr-2" />{t("client.src.try_again")}</Button>
          <Button variant="outline" onClick={onGoHome} className="flex-1">
            <Home className="w-4 h-4 mr-2" />{t("client.src.go_home")}</Button>
        </div>
      </CardContent>
    </Card>
  </div>;
};

export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      hasError: false,
      error: null,
      errorInfo: null
    };
  }
  static getDerivedStateFromError(error: Error): Partial<State> {
    return {
      hasError: true,
      error
    };
  }
  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('ErrorBoundary caught an error:', error, errorInfo);
    this.setState({
      error,
      errorInfo
    });

    // Call custom error handler if provided
    if (this.props.onError) {
      this.props.onError(error, errorInfo);
    }

    // Log to external service in production
    if (!isDevelopment) {
      // TODO: Send error to logging service
      console.log('Would send error to logging service:', {
        error: error.message,
        stack: error.stack,
        componentStack: errorInfo.componentStack
      });
    }
  }
  handleReset = () => {
    this.setState({
      hasError: false,
      error: null,
      errorInfo: null
    });
  };
  handleGoHome = () => {
    window.location.href = '/';
  };
  render() {
    if (this.state.hasError) {
      // Custom fallback UI
      if (this.props.fallback) {
        return this.props.fallback;
      }

      // Default error UI
      return <ErrorBoundaryFallback 
               error={this.state.error} 
               errorInfo={this.state.errorInfo} 
               onReset={this.handleReset} 
               onGoHome={this.handleGoHome} 
             />;
    }
    return this.props.children;
  }
}

// Hook for functional components
export const useErrorHandler = () => {
  return (error: Error, errorInfo?: ErrorInfo) => {
    console.error('Error caught by error handler:', error, errorInfo);

    // Log to external service in production
    if (!isDevelopment) {
      // TODO: Send error to logging service
    }
  };
};

// HOC for wrapping components
export const withErrorBoundary = <P extends object,>(Component: React.ComponentType<P>, fallback?: ReactNode, onError?: (error: Error, errorInfo: ErrorInfo) => void) => {
  const WrappedComponent = (props: P) => {
    const {
      t
    } = useTranslation();
    return <ErrorBoundary fallback={fallback} onError={onError}>
      <Component {...props} />
    </ErrorBoundary>;
  };
  WrappedComponent.displayName = `withErrorBoundary(${Component.displayName || Component.name})`;
  return WrappedComponent;
};
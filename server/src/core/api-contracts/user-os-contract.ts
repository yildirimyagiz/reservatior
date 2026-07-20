export interface UserOSAPIContract {
  createUser(params: any): Promise<any>;
  getUser(userId: string): Promise<any>;
  updateUser(userId: string, params: any): Promise<any>;
  suspendUser(userId: string): Promise<any>;
  reactivateUser(userId: string): Promise<any>;
}

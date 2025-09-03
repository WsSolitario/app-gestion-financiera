class AppRoutes {
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const groups = '/groups';
  static const groupForm = '/groups/new';
  static const groupDetail = '/groups/:id';
  static const expenses = '/groups/:id/expenses';
  static const expenseForm = '/groups/:id/expenses/new';
  static const expenseDetail = '/groups/:id/expenses/:expId';
  static const invitations = '/invitations';
  static const invitationAccept = '/invitations/accept';
  static const groupMembers = '/groups/:id/members';
  static const groupBalances = '/groups/:id/balances';
  static const payments = '/groups/:id/payments';
  static const paymentForm = '/groups/:id/payments/new';
  static const paymentDetail = '/groups/:id/payments/:payId';
}

# Admin Panel - Quick Start Guide

## ✅ What Was Created

### 📁 File Structure
```
src/
├── lib/
│   ├── admin.ts                          # Admin auth utilities (requireAdmin, isAdmin)
│   └── prisma.ts                         # Prisma client
├── types/
│   └── next-auth.d.ts                    # NextAuth type extensions
├── components/
│   └── admin/
│       ├── credit-adjuster.tsx           # Interactive credit management
│       └── ticket-responder.tsx          # Support ticket response system
├── app/
│   ├── [locale]/
│   │   └── admin/
│   │       ├── layout.tsx                # Admin layout with sidebar
│   │       ├── page.tsx                  # Dashboard
│   │       ├── users/
│   │       │   ├── page.tsx              # User list
│   │       │   └── [id]/page.tsx         # User details
│   │       ├── generations/page.tsx      # Generation monitoring
│   │       ├── walkthroughs/page.tsx     # Walkthrough monitoring
│   │       ├── brochures/page.tsx        # Brochure management
│   │       ├── payments/page.tsx         # Payment management
│   │       ├── tickets/
│   │       │   ├── page.tsx              # Ticket list
│   │       │   └── [id]/page.tsx         # Ticket details & response
│   │       ├── analytics/page.tsx        # Analytics dashboard
│   │       └── system/page.tsx           # System monitoring
│   └── api/
│       └── admin/
│           ├── users/
│           │   ├── route.ts              # List/Create users
│           │   └── [id]/route.ts         # Get/Update/Delete user
│           ├── credits/
│           │   └── adjust/route.ts       # Adjust user credits
│           └── tickets/
│               └── [id]/route.ts         # Get/Update ticket
└── middleware.ts                         # Updated with admin protection
```

## 🎯 Key Features

### 1. Dashboard (`/[locale]/admin`)
- Overview statistics (users, generations, revenue)
- Recent activity feeds
- Quick metrics at a glance

### 2. User Management
- **List**: Search, filter, paginate users
- **Details**: Complete profile with credit adjustment
- **Actions**: Create, edit, delete, adjust credits

### 3. Content Monitoring
- **Generations**: All AI image/video generations
- **Walkthroughs**: 3D walkthrough jobs with status tracking
- **Brochures**: PDF brochure management

### 4. Financial
- **Payments**: Order tracking, revenue stats
- **Subscriptions**: Active subscription count
- **Credits**: User credit management system

### 5. Support
- **Tickets**: Full support ticket system
- **Responses**: Admin response interface
- **Status**: Track ticket resolution

### 6. System
- **Monitoring**: System health metrics
- **Services**: Service status tracking
- **Logs**: Recent system activity

## 🚀 Quick Start

### 1. Create Admin User
```bash
curl -X POST http://localhost:3000/api/admin/create-user \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@yourdomain.com",
    "password": "YourSecurePassword123!",
    "name": "Admin User",
    "secret": "YOUR_ADMIN_SECRET"
  }'
```

### 2. Set Environment Variable
Add to `.env`:
```env
ADMIN_SECRET=your_secret_key_here
```

### 3. Access Admin Panel
Navigate to: `http://localhost:3000/en/admin`

## 🔐 Security Features

✅ Role-based access control (USER/ADMIN)
✅ Middleware protection on all admin routes
✅ Server-side role verification
✅ API endpoint protection
✅ Session-based authentication
✅ Automatic redirect for unauthorized users

## 📊 Admin Capabilities

### User Management
- ✅ View all users with filtering
- ✅ Search by email/name
- ✅ Adjust credits (add/subtract/set)
- ✅ View user activity
- ✅ Track subscriptions & trials
- ✅ Monitor risk levels

### Content Management
- ✅ Monitor all generations
- ✅ Track walkthrough jobs
- ✅ Manage brochures
- ✅ View generation costs

### Support Management
- ✅ View all tickets
- ✅ Filter by status/priority
- ✅ Respond to customers
- ✅ Update ticket status
- ✅ Access customer profiles

### Financial Management
- ✅ View all orders
- ✅ Track revenue
- ✅ Monitor subscriptions
- ✅ Filter by payment status

## 🎨 UI/UX Features

- 🌓 Dark theme optimized for long sessions
- 📱 Fully responsive design
- 🔍 Advanced search and filtering
- 📄 Pagination for large datasets
- 🎯 Quick actions and shortcuts
- 📊 Visual statistics
- 🏷️ Color-coded status badges
- ⚡ Fast server-side rendering

## 📡 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/admin/users` | List users |
| POST | `/api/admin/users` | Create user |
| GET | `/api/admin/users/[id]` | Get user details |
| PATCH | `/api/admin/users/[id]` | Update user |
| DELETE | `/api/admin/users/[id]` | Delete user |
| POST | `/api/admin/credits/adjust` | Adjust credits |
| GET | `/api/admin/tickets/[id]` | Get ticket |
| PATCH | `/api/admin/tickets/[id]` | Update ticket |

## 🧪 Testing Access

### Test Admin Access
1. Login with admin credentials
2. Navigate to `/en/admin`
3. You should see the admin dashboard

### Test Non-Admin Access
1. Login with regular user credentials
2. Try to navigate to `/en/admin`
3. Should redirect to home page

## 📝 Usage Examples

### Adjust User Credits
```typescript
// Via UI: Click user → "Adjust Credits" button
// Via API:
POST /api/admin/credits/adjust
{
  "userId": "user_id_here",
  "amount": 100,
  "operation": "add" // or "subtract" or "set"
}
```

### Respond to Ticket
```typescript
// Via UI: Click ticket → Fill response form
// Via API:
PATCH /api/admin/tickets/[id]
{
  "status": "RESOLVED",
  "adminResponse": "Your response here"
}
```

## 🔄 Workflow Integration

### Daily Admin Tasks
1. **Morning**: Check dashboard for overnight activity
2. **Review**: Check support tickets, respond to urgent ones
3. **Monitor**: Review failed generations/walkthroughs
4. **Financial**: Check new orders and subscriptions
5. **System**: Monitor system health metrics

### User Support Workflow
1. User submits ticket
2. Admin sees ticket in `/admin/tickets`
3. Admin reviews and responds
4. Status updated to "Resolved"
5. User receives notification (when email system is integrated)

## ⚙️ Configuration

### Required Environment Variables
```env
DATABASE_URL="postgresql://..."
NEXTAUTH_SECRET="..."
NEXTAUTH_URL="http://localhost:3000"
ADMIN_SECRET="..."
```

### Optional Enhancements
- Email service for notifications
- Slack/Discord webhooks for alerts
- Advanced analytics integration
- Automated backup systems

## 📈 Performance Notes

- All pages use server-side rendering
- Pagination: 20 items per page (configurable)
- Database queries optimized with Prisma
- Efficient filtering and search

## 🐛 Troubleshooting

**Can't access admin panel**
- Check user role in database: `SELECT role FROM "User" WHERE email = 'your@email.com'`
- Ensure you're logged in
- Clear browser cache and cookies

**Credits not updating**
- Check console for API errors
- Verify database connection
- Check Prisma schema migrations

**Tickets not loading**
- Ensure HelpTicket model exists
- Run Prisma migrations
- Check database permissions

## 🎯 Next Steps

1. ✅ Test admin login
2. ✅ Create first admin user
3. ✅ Explore all sections
4. ✅ Test credit adjustment
5. ✅ Test ticket response
6. Configure email notifications (optional)
7. Set up monitoring alerts (optional)
8. Customize branding (optional)

## 📞 Support

For questions or issues with the admin panel:
- Check `ADMIN_PANEL_README.md` for detailed documentation
- Review code comments in each file
- Test API endpoints using curl or Postman

---

**Status**: ✅ Complete and Ready to Use  
**Version**: 1.0.0  
**Created**: 2026-03-02

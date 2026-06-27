# Admin Panel Documentation

## Overview

Comprehensive admin panel for managing users, monitoring system operations, handling payments, and providing customer support for the AtlasVS platform.

## 🚀 Features

### 1. **Dashboard** (`/[locale]/admin`)
- Real-time statistics overview
- Total users, generations, walkthroughs, brochures
- Active trials and revenue metrics
- Recent user registrations
- Recent generation activity

### 2. **User Management** (`/[locale]/admin/users`)
- **List View**: Paginated user list with search and filtering
  - Search by email or name
  - Filter by role (USER, ADMIN)
  - View user stats (generations, walkthroughs, orders)
  - Credits and subscription status
  
- **User Details** (`/[locale]/admin/users/[id]`)
  - Complete user profile
  - Account information (email, phone, join date)
  - Trial/Subscription status
  - Credit management with interactive adjuster
  - Activity history (generations, walkthroughs, orders)
  - Quick actions (edit, adjust credits)

### 3. **Generation Monitoring** (`/[locale]/admin/generations`)
- View all AI generations (images, videos, panoramas)
- Filter by generation type
- Preview thumbnails
- User attribution
- Cost tracking per generation
- Direct links to outputs

### 4. **Walkthrough Monitoring** (`/[locale]/admin/walkthroughs`)
- Monitor 3D walkthrough generation jobs
- Filter by status (QUEUED, PROCESSING, COMPLETED, FAILED)
- Filter by pipeline type
- Track photo counts and costs
- Property information
- Video output links

### 5. **Brochure Management** (`/[locale]/admin/brochures`)
- View all generated brochures
- User and property attribution
- Image counts per brochure
- PDF download links
- Creation timestamps

### 6. **Payment Management** (`/[locale]/admin/payments`)
- **Revenue Statistics**:
  - Total revenue
  - Total orders
  - Active subscriptions
  - Average order value
  
- **Order Management**:
  - Filter by status (PENDING, PAID, FULFILLED, CANCELLED, REFUNDED)
  - Customer information
  - Order details and items
  - Payment tracking

### 7. **Support Ticket System** (`/[locale]/admin/tickets`)
- **Ticket List**:
  - Filter by status and priority
  - View all customer support requests
  - Quick status overview
  
- **Ticket Details** (`/[locale]/admin/tickets/[id]`):
  - Full ticket conversation
  - Customer information
  - Interactive response system
  - Status and priority management
  - Customer profile quick access

### 8. **Analytics Dashboard** (`/[locale]/admin/analytics`)
- User growth trends
- Generation type distribution
- Revenue tracking
- Top users by activity
- Platform metrics

### 9. **System Monitoring** (`/[locale]/admin/system`)
- System health metrics (CPU, Memory, Disk)
- Service status monitoring
- Active connections and queue stats
- Recent system logs
- Environment configuration

## 🔐 Security & Access Control

### Role-Based Access
- Only users with `role: ADMIN` can access the admin panel
- Middleware protection at `/admin` routes
- API endpoint protection with `isAdmin()` check
- Server-side validation with `requireAdmin()`

### Authentication Flow
1. User must be authenticated (redirects to `/auth/signin` if not)
2. Server validates admin role from database
3. Access granted only if `user.role === "ADMIN"`

### Protected Routes
- All `/[locale]/admin/*` routes require admin role
- Middleware handles initial authentication check
- Server components verify role on each page load

## 📡 API Endpoints

### User Management
```typescript
GET    /api/admin/users              // List users with filtering
POST   /api/admin/users              // Create new user
GET    /api/admin/users/[id]         // Get user details
PATCH  /api/admin/users/[id]         // Update user
DELETE /api/admin/users/[id]         // Delete user
```

### Credit Management
```typescript
POST   /api/admin/credits/adjust     // Adjust user credits
```

### Ticket Management
```typescript
GET    /api/admin/tickets/[id]       // Get ticket details
PATCH  /api/admin/tickets/[id]       // Update ticket status/response
```

## 🎨 UI Components

### Interactive Components
- **CreditAdjuster**: Modal for adding/subtracting/setting user credits
- **TicketResponder**: Form for responding to support tickets with status updates

### Design System
- Dark theme (Slate color palette)
- Consistent card layouts
- Status badges with color coding
- Responsive tables
- Interactive filters and search

### Color Coding
- **Status Colors**:
  - Green: Active/Completed/Resolved
  - Blue: Processing/Open/User
  - Yellow: Pending/In Progress/Trial
  - Red: Failed/Cancelled/Urgent
  - Purple: Admin role
  - Orange: High priority

## 🛠️ Setup & Configuration

### Prerequisites
1. PostgreSQL database with Prisma schema
2. NextAuth.js configured
3. Admin user created with `role: ADMIN`

### Creating Admin User
Use the existing endpoint:
```bash
curl -X POST http://localhost:3000/api/admin/create-user \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@example.com",
    "password": "secure_password",
    "name": "Admin User",
    "secret": "YOUR_ADMIN_SECRET"
  }'
```

Set `ADMIN_SECRET` in your `.env`:
```env
ADMIN_SECRET=your_secret_key_here
```

### Database Schema
The admin panel uses these Prisma models:
- `User` (with `role` field: USER | ADMIN)
- `Generation`
- `Walkthrough`
- `Brochure`
- `Order`
- `HelpTicket`
- `TrialProfile`
- `Subscription`

## 📊 Features by Section

### Dashboard Metrics
- **User Metrics**: Total users, active trials
- **Content Metrics**: Generations, walkthroughs, brochures
- **Financial Metrics**: Total revenue
- **Recent Activity**: Latest users and generations

### User Management Features
- ✅ Search users by email/name
- ✅ Filter by role
- ✅ View user activity statistics
- ✅ Adjust credits (add/subtract/set)
- ✅ View trial/subscription status
- ✅ Track risk levels
- ✅ Export capabilities (placeholder)

### Monitoring Features
- ✅ Real-time generation tracking
- ✅ Walkthrough pipeline status
- ✅ Payment processing status
- ✅ Support ticket management
- ✅ System health monitoring
- ✅ Service uptime tracking

## 🔄 Workflow Examples

### Adjusting User Credits
1. Navigate to user detail page
2. Click "Adjust Credits"
3. Select operation (Add/Subtract/Set)
4. Enter amount
5. Preview new balance
6. Confirm adjustment

### Responding to Support Ticket
1. View ticket from list
2. Read customer message
3. Update status (Open → In Progress → Resolved)
4. Write response
5. Submit (customer receives notification)

### Monitoring Generation Jobs
1. View generations page
2. Filter by type if needed
3. Check status and outputs
4. Track credit costs
5. Access user profiles directly

## 🚀 Future Enhancements

### Planned Features
- [ ] Bulk user operations
- [ ] Advanced analytics charts
- [ ] Email notifications for admins
- [ ] Audit log for admin actions
- [ ] Custom report generation
- [ ] User impersonation (for support)
- [ ] Automated ticket responses
- [ ] Real-time system metrics
- [ ] Advanced filtering and sorting
- [ ] Export to CSV/Excel

### Integration Opportunities
- Stripe dashboard integration
- Email service integration
- SMS notifications
- Slack/Discord webhooks for alerts
- Analytics platforms (Google Analytics, Mixpanel)

## 📱 Responsive Design

The admin panel is fully responsive:
- **Desktop**: Full sidebar navigation, multi-column layouts
- **Tablet**: Collapsible sidebar, responsive grids
- **Mobile**: Bottom navigation, stacked layouts

## ⚡ Performance

### Optimizations
- Server-side rendering for fast initial loads
- Pagination for large data sets (20 items per page)
- Efficient database queries with Prisma
- Index optimization on search fields
- Lazy loading for images

### Database Queries
- Use `include` for related data
- Use `select` to limit fields
- Implement proper indexes on filtered fields
- Use `_count` for aggregations

## 🔍 Troubleshooting

### Common Issues

**Admin Access Denied**
- Verify user role in database: `SELECT role FROM "User" WHERE email = 'your@email.com'`
- Ensure session includes role in JWT token
- Check middleware is not blocking requests

**API Endpoints Not Working**
- Verify `isAdmin()` function works correctly
- Check database connection
- Review API route logs for errors

**Credits Not Updating**
- Check API response for errors
- Verify user ID is correct
- Ensure database transaction succeeds

## 📝 Best Practices

### Admin Usage
1. Always verify user identity before making changes
2. Document significant credit adjustments
3. Respond to high-priority tickets first
4. Monitor system health regularly
5. Review failed generations for patterns

### Security
1. Never share admin credentials
2. Use strong passwords
3. Regularly audit admin actions
4. Monitor for suspicious activity
5. Keep admin access limited to necessary personnel

## 🎯 Access URLs

- Dashboard: `/[locale]/admin`
- Users: `/[locale]/admin/users`
- Generations: `/[locale]/admin/generations`
- Walkthroughs: `/[locale]/admin/walkthroughs`
- Brochures: `/[locale]/admin/brochures`
- Payments: `/[locale]/admin/payments`
- Tickets: `/[locale]/admin/tickets`
- Analytics: `/[locale]/admin/analytics`
- System: `/[locale]/admin/system`

Replace `[locale]` with your language code (e.g., `en`, `tr`, `es`, `de`)

## 📞 Support

For admin panel issues or feature requests, contact the development team or create an issue in the repository.

---

**Version**: 1.0.0  
**Last Updated**: 2026-03-02  
**Maintained By**: AtlasVS Development Team

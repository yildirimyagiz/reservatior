export class AIEmailTemplates {
  /**
   * Core CSS styles used across all Reservatior templates
   */
  private static readonly CORE_CSS = `
    body { background-color: #f4f4f5; color: #18181b; font-family: 'Inter', Helvetica, Arial, sans-serif; margin: 0; padding: 0; }
    .container { max-width: 650px; margin: 40px auto; background-color: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
    .logo-container { text-align: center; padding: 25px 0; background: #ffffff; border-bottom: 1px solid #e4e4e7; }
    .logo-container h1 { margin: 0; color: #2563eb; font-size: 28px; letter-spacing: -1px; font-weight: 800; }
    .logo-container p { margin: 5px 0 0 0; color: #71717a; font-size: 12px; text-transform: uppercase; letter-spacing: 2px; }
    .footer { text-align: center; padding: 30px 20px; font-size: 13px; color: #a1a1aa; background-color: #f8fafc; border-top: 1px solid #e4e4e7; }
    .footer-links a { color: #2563eb; text-decoration: none; margin: 0 10px; }
    .btn { display: inline-block; padding: 14px 28px; background-color: #2563eb; color: #ffffff; text-decoration: none; font-weight: 600; border-radius: 8px; margin-top: 25px; transition: background 0.3s; }
    .btn:hover { background-color: #1d4ed8; }
    .banner { width: 100%; height: 180px; display: flex; align-items: center; justify-content: center; background-size: cover; background-position: center; position: relative; }
    .banner-overlay { position: absolute; inset: 0; background: rgba(0,0,0,0.4); }
    .banner-content { position: relative; z-index: 10; color: white; text-align: center; padding: 0 20px; }
    .banner h2 { margin: 0; font-size: 32px; text-shadow: 0 2px 10px rgba(0,0,0,0.5); }
    .content-wrapper { padding: 40px 30px; line-height: 1.6; }
  `;

  /**
   * Shared Header (Logo)
   */
  private static getHeader(): string {
    return `
      <div class="logo-container">
        <h1>Reservatior</h1>
        <p>Premium Real Estate</p>
      </div>
    `;
  }

  /**
   * Shared Footer
   */
  private static getFooter(): string {
    return `
      <div class="footer">
        <div class="footer-links">
          <a href="#">View Properties</a> | 
          <a href="#">Contact Agent</a> | 
          <a href="#">Unsubscribe</a>
        </div>
        <p style="margin-top: 20px;">&copy; ${new Date().getFullYear()} Reservatior. All rights reserved.</p>
        <p>123 Luxury Avenue, Prestige District, City</p>
      </div>
    `;
  }

  /**
   * 1. Standard Weekly Newsletter (Blog guides, market updates)
   */
  static generateNewsletter(subject: string, contentHtml: string, recipientName: string): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <style>${this.CORE_CSS}</style>
      </head>
      <body>
        <div class="container">
          ${this.getHeader()}
          <div class="banner" style="background-image: url('https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1000&q=80');">
            <div class="banner-overlay"></div>
            <div class="banner-content">
              <h2>Weekly Market Insights</h2>
            </div>
          </div>
          <div class="content-wrapper">
            <h3 style="color: #18181b;">Hello ${recipientName || 'Valued Client'},</h3>
            ${contentHtml}
            <div style="text-align: center;">
              <a href="https://reservatior.com/guides" class="btn">Read Full Guides</a>
            </div>
          </div>
          ${this.getFooter()}
        </div>
      </body>
      </html>
    `;
  }

  /**
   * 2. New Listing Alert (Just Listed)
   */
  static generateNewListingAlert(property: any, recipientName: string): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <style>
          ${this.CORE_CSS}
          .listing-card { border: 1px solid #e4e4e7; border-radius: 8px; padding: 20px; background: #fafafa; margin-top: 20px; }
          .price-tag { font-size: 24px; color: #059669; font-weight: 700; margin-bottom: 10px; }
          .specs { display: flex; gap: 15px; color: #52525b; font-size: 14px; margin-bottom: 15px; }
        </style>
      </head>
      <body>
        <div class="container">
          ${this.getHeader()}
          <div class="banner" style="background-image: url('https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=1000&q=80');">
            <div class="banner-overlay" style="background: rgba(37,99,235,0.7);"></div>
            <div class="banner-content">
              <h2>Just Listed in ${property.city}</h2>
            </div>
          </div>
          <div class="content-wrapper">
            <p>Dear ${recipientName},</p>
            <p>We thought you'd be the first to know about this spectacular new property that just hit the market.</p>
            
            <div class="listing-card">
              <h3 style="margin-top:0;">${property.name || 'Beautiful Home'}</h3>
              <div class="price-tag">${property.currency} ${property.listingPrice?.toLocaleString() || 'Contact for Price'}</div>
              <div class="specs">
                <span>🛏️ ${property.bedrooms || '-'} Beds</span>
                <span>🛁 ${property.bathrooms || '-'} Baths</span>
                <span>📐 ${property.areaSqm || '-'} Sqm</span>
              </div>
              <p style="color: #71717a; font-size: 14px;">${property.addressLine1}, ${property.city}</p>
            </div>

            <div style="text-align: center;">
              <a href="https://reservatior.com/properties/${property.id}" class="btn">View Photos & Details</a>
            </div>
          </div>
          ${this.getFooter()}
        </div>
      </body>
      </html>
    `;
  }

  /**
   * 3. Special Deals / Discounts (Fırsat İndirimleri)
   */
  static generateSpecialDeal(contentHtml: string, recipientName: string, discountPercentage: string = "15%"): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <style>
          ${this.CORE_CSS}
          .discount-badge { background: #ef4444; color: white; display: inline-block; padding: 5px 15px; border-radius: 20px; font-weight: bold; font-size: 18px; margin-bottom: 20px; animation: pulse 2s infinite; }
        </style>
      </head>
      <body>
        <div class="container">
          ${this.getHeader()}
          <div class="banner" style="background-image: url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1000&q=80');">
            <div class="banner-overlay" style="background: rgba(220, 38, 38, 0.8);"></div>
            <div class="banner-content">
              <h2>Price Drop Alert!</h2>
              <p style="font-size: 20px; font-weight:bold;">Exclusive Off-Market Deals</p>
            </div>
          </div>
          <div class="content-wrapper" style="text-align: center;">
            <div class="discount-badge">Up To ${discountPercentage} OFF Market Value</div>
            <p style="font-size: 18px;">Hi ${recipientName},</p>
            ${contentHtml}
            <a href="https://reservatior.com/deals" class="btn" style="background-color: #ef4444;">Unlock the Deals</a>
          </div>
          ${this.getFooter()}
        </div>
      </body>
      </html>
    `;
  }

  /**
   * 4. Birthday Celebration Template
   */
  static generateBirthdayTemplate(contentHtml: string, recipientName: string): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <style>${this.CORE_CSS}</style>
      </head>
      <body>
        <div class="container">
          ${this.getHeader()}
          <div class="banner" style="background-image: url('https://images.unsplash.com/photo-1530103862676-de8892b07439?auto=format&fit=crop&w=1000&q=80');">
            <div class="banner-overlay" style="background: rgba(245, 158, 11, 0.7);"></div>
            <div class="banner-content">
              <h2>🎉 Happy Birthday! 🎉</h2>
            </div>
          </div>
          <div class="content-wrapper" style="text-align: center;">
            <h3 style="font-size: 24px;">Wishing you the best, ${recipientName}!</h3>
            ${contentHtml}
            <a href="https://reservatior.com/gifts" class="btn" style="background-color: #f59e0b;">Claim Your Gift</a>
          </div>
          ${this.getFooter()}
        </div>
      </body>
      </html>
    `;
  }

  /**
   * 5. Cultural & Religious Holidays (Multi-cultural)
   */
  static generateHolidayTemplate(holidayName: string, contentHtml: string, recipientName: string): string {
    let overlayColor = "rgba(37, 99, 235, 0.8)";
    let bannerImage = "https://images.unsplash.com/photo-1512389142860-9c449e58a543?auto=format&fit=crop&w=1000&q=80"; // Default festive

    if (holidayName.toLowerCase().includes("christmas")) {
      overlayColor = "rgba(185, 28, 28, 0.8)";
      bannerImage = "https://images.unsplash.com/photo-1512389142860-9c449e58a543?auto=format&fit=crop&w=1000&q=80";
    } else if (holidayName.toLowerCase().includes("eid") || holidayName.toLowerCase().includes("ramadan")) {
      overlayColor = "rgba(4, 120, 87, 0.8)";
      bannerImage = "https://images.unsplash.com/photo-1564769625905-50e93615e769?auto=format&fit=crop&w=1000&q=80";
    } else if (holidayName.toLowerCase().includes("hanukkah")) {
      overlayColor = "rgba(29, 78, 216, 0.8)";
      bannerImage = "https://images.unsplash.com/photo-1607434455823-35639f2802ab?auto=format&fit=crop&w=1000&q=80";
    }

    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <style>${this.CORE_CSS}</style>
      </head>
      <body>
        <div class="container">
          ${this.getHeader()}
          <div class="banner" style="background-image: url('${bannerImage}');">
            <div class="banner-overlay" style="background: ${overlayColor};"></div>
            <div class="banner-content">
              <h2>${holidayName}</h2>
            </div>
          </div>
          <div class="content-wrapper" style="text-align: center;">
            <p style="font-size: 18px;">Dear ${recipientName},</p>
            ${contentHtml}
            <div style="margin-top: 30px;">
              <a href="https://reservatior.com" class="btn">Explore Holiday Estates</a>
            </div>
          </div>
          ${this.getFooter()}
        </div>
      </body>
      </html>
    `;
  }

  /**
   * 6. Onboarding / Welcome Email
   */
  static generateWelcomeEmail(recipientName: string, dashboardUrl: string): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <style>${this.CORE_CSS}</style>
      </head>
      <body>
        <div class="container">
          ${this.getHeader()}
          <div class="content-wrapper" style="text-align: center;">
            <h2 style="color: #2563eb;">Welcome to Reservatior</h2>
            <p>Hi ${recipientName},</p>
            <p>We are thrilled to welcome you to the ultimate digital real estate platform. Your account is now active.</p>
            <p>You can now save favorites, track market values, and communicate directly with top-tier agents.</p>
            <a href="${dashboardUrl}" class="btn">Access Your Dashboard</a>
          </div>
          ${this.getFooter()}
        </div>
      </body>
      </html>
    `;
  }

  /**
   * 7. Password Reset
   */
  static generatePasswordReset(recipientName: string, resetUrl: string): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <style>${this.CORE_CSS}</style>
      </head>
      <body>
        <div class="container">
          ${this.getHeader()}
          <div class="content-wrapper">
            <h2>Password Reset Request</h2>
            <p>Hi ${recipientName},</p>
            <p>We received a request to reset your Reservatior password. Click the button below to choose a new password.</p>
            <div style="text-align: center;">
              <a href="${resetUrl}" class="btn">Reset Password</a>
            </div>
            <p style="margin-top: 20px; font-size: 12px; color: #71717a;">If you did not make this request, you can safely ignore this email.</p>
          </div>
          ${this.getFooter()}
        </div>
      </body>
      </html>
    `;
  }

  /**
   * 8. Legal & Contract Emails (Satış, Kiralama, Tahliye, Kat Karşılığı)
   */
  static generateContractEmail(recipientName: string, contractType: string, actionUrl: string, propertyName: string): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <style>${this.CORE_CSS}</style>
      </head>
      <body>
        <div class="container">
          ${this.getHeader()}
          <div class="content-wrapper">
            <h2 style="color: #18181b; border-bottom: 2px solid #e4e4e7; padding-bottom: 10px;">Official Document Required</h2>
            <p>Dear ${recipientName},</p>
            <p>A new legal document regarding <strong>${propertyName}</strong> requires your immediate attention.</p>
            <p><strong>Document Type:</strong> ${contractType}</p>
            <p>Please review and digitally sign the document using our secure portal to proceed with the transaction.</p>
            <div style="text-align: center;">
              <a href="${actionUrl}" class="btn" style="background-color: #0f172a;">Review & Sign Document</a>
            </div>
          </div>
          ${this.getFooter()}
        </div>
      </body>
      </html>
    `;
  }

  /**
   * 9. Transactional Alert (Satın Alma / Kiralama Talebi)
   */
  static generateTransactionAlert(recipientName: string, requestType: string, propertyName: string, status: string): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <style>
          ${this.CORE_CSS}
          .status-badge { display: inline-block; padding: 6px 12px; border-radius: 4px; font-weight: bold; font-size: 14px; background: #dcfce7; color: #166534; }
        </style>
      </head>
      <body>
        <div class="container">
          ${this.getHeader()}
          <div class="content-wrapper">
            <h2>${requestType} Status Update</h2>
            <p>Hi ${recipientName},</p>
            <p>Your ${requestType.toLowerCase()} for <strong>${propertyName}</strong> has been updated.</p>
            <p>Current Status: <span class="status-badge">${status}</span></p>
            <p>Our team is processing the paperwork. You will receive the official digital contracts shortly.</p>
            <div style="text-align: center;">
              <a href="https://reservatior.com/dashboard/transactions" class="btn">Track Progress</a>
            </div>
          </div>
          ${this.getFooter()}
        </div>
      </body>
      </html>
    `;
  }
}

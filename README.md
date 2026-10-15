# מדריך ראשי — ניהול משתמשים, קבוצות והרשאות

## תאימות
כל הסקריפטים בתיקיית `linux/` מבוססים על `shadow-utils` ו-`coreutils`, שהם חלק
סטנדרטי מכל ההפצות הבאות ללא שינוי בפקודות עצמן:

| מערכת | גרסאות נתמכות |
|---|---|
| Ubuntu | 20.04, 22.04, 24.04 |
| Debian | 10, 11, 12 (3 גרסאות אחורה) |
| CentOS / RHEL clones | 7, 8, 9, וכן Rocky/Alma/Stream |

אם `sudo` לא מותקן במערכת מינימלית (למשל קונטיינר), התקן קודם:
`apt install sudo` (Ubuntu/Debian) או `yum install sudo` / `dnf install sudo` (CentOS).

תיקיית `windows/` מכילה PowerShell מקביל, נבדק מבחינת תחביר ל-PowerShell 5.1+ / 7+.

---

## טבלת סקריפטים — Linux

| # | שם עברי קצר | שם אנגלי קצר | קובץ | מה זה עושה |
|---|---|---|---|---|
| 1 | יצירת משתמש | Create-User | `01-create-user.sh` | יוצר משתמש חדש עם תיקיית בית וקבוצה פרטית |
| 2 | שינוי סיסמה | Set-Password | `02-change-password.sh` | משנה סיסמה למשתמש קיים, אינטראקטיבי |
| 3 | יצירת קבוצה | Create-Group | `03-create-group.sh` | יוצר קבוצה חדשה |
| 4 | מחיקת קבוצה | Delete-Group | `04-delete-group.sh` | מוחק קבוצה קיימת |
| 5 | הוספה לקבוצה | Add-To-Group | `05-add-user-to-group.sh` | מוסיף משתמש לקבוצה בלי לפגוע בקבוצות אחרות |
| 6 | עדכון משתמש | Modify-User | `06-modify-user.sh` | משנה תיקיית בית ו/או shell |
| 7 | מחיקת משתמש | Delete-User | `07-delete-user.sh` | מוחק משתמש, עם אופציה למחוק גם תיקיית בית |
| 8 | בעלות על תיקייה | Set-Owner | `08-set-owner-chown.sh` | קובע בעלים וקבוצה לתיקייה/קובץ, רקורסיבי |
| 9 | הרשאות תיקייה | Set-Permissions | `09-set-permissions-chmod.sh` | קובע הרשאות מספריות או סימבוליות, רקורסיבי |
| 10 | מידע משתמש | User-Info | `10-user-info.sh` | לוח מידע: מי אני, מי מחובר, היסטוריית התחברויות |
| 11 | הקמה מלאה | Full-Provision | `11-provision-user-folder-access.sh` | תרחיש שלם: משתמש + קבוצה + הרשאות על תיקייה, בפקודה אחת |
| 12 | סיסמה אוטומטית | Auto-Password | `12-set-password-noninteractive.sh` | קובע סיסמה בלי אינטראקציה, לסקריפטים אוטומטיים |

כל הסקריפטים דורשים `sudo`. שימוש: `sudo ./01-create-user.sh dan`
לאחר הורדה, תן להם הרשאת הרצה: `chmod +x linux/*.sh`

## טבלת סקריפטים — Windows (PowerShell)

| # | שם עברי קצר | שם אנגלי קצר | קובץ | מה זה עושה |
|---|---|---|---|---|
| 1 | יצירת משתמש | Create-User | `01-Create-User.ps1` | יוצר משתמש מקומי חדש |
| 2 | שינוי סיסמה | Set-Password | `02-Change-Password.ps1` | משנה סיסמה למשתמש קיים |
| 3 | יצירת קבוצה | Create-Group | `03-Create-Group.ps1` | יוצר קבוצה מקומית חדשה |
| 4 | מחיקת קבוצה | Delete-Group | `04-Delete-Group.ps1` | מוחק קבוצה מקומית |
| 5 | הוספה לקבוצה | Add-To-Group | `05-Add-User-To-Group.ps1` | מוסיף משתמש לקבוצה מקומית |
| 6 | עדכון משתמש | Modify-User | `06-Modify-User.ps1` | משנה שם מלא, תיאור, נעילה/פתיחה |
| 7 | מחיקת משתמש | Delete-User | `07-Delete-User.ps1` | מוחק משתמש מקומי |
| 8 | בעלות על תיקייה | Set-Owner | `08-Set-Owner.ps1` | קובע בעלים לתיקייה/קובץ |
| 9 | הרשאות תיקייה | Set-Permissions | `09-Set-Permissions.ps1` | קובע הרשאות דרך `icacls`, רקורסיבי |
| 10 | מידע משתמש | User-Info | `10-User-Info.ps1` | לוח מידע: משתמש נוכחי, קבוצות, סשנים, רשימת משתמשים |
| 11 | הקמה מלאה | Full-Provision | `11-Provision-User-Folder-Access.ps1` | תרחיש שלם: משתמש + קבוצה + הרשאות תיקייה |

שימוש לדוגמה: `.\01-Create-User.ps1 -Username dan -Password (Read-Host -AsSecureString)`
דורש הרצה כ-Administrator.

---

## הערה קריטית לגבי `useradd -p`

הפקודה שרשמת, `useradd -d -s /bin/bash -U -p '123123'`, לא תעבוד כמצופה.
דגל `-p` ב-`useradd` וב-`usermod` מצפה ל**hash מוצפן**, לא לסיסמה גולמית.
אם תעביר סיסמה גולמית היא תיכנס כטקסט ל-`/etc/shadow` והחשבון בפועל ננעל.

שתי דרכים נכונות:
1. **אינטראקטיבי, הכי בטוח**: `sudo passwd username` (סקריפט 2).
2. **אוטומטי לסקריפטים**: `echo 'username:password' | chpasswd` (סקריפט 12).
3. אם חייבים hash בפועל: `openssl passwd -6 'הסיסמה'` ואז להעביר את הפלט ל-`-p`.

---

## אופציות נוספות שכדאי להכיר — Linux

| פקודה | מה היא עושה |
|---|---|
| `usermod -L` / `usermod -U` | נעילת חשבון / פתיחת חשבון בלי למחוק אותו |
| `passwd -l` / `passwd -u` | נעילת סיסמה / פתיחתה |
| `chage -l username` | הצגת מדיניות תפוגת סיסמה |
| `chage -M 90 username` | הגבלת תוקף סיסמה ל-90 יום |
| `deluser --remove-home` | (Ubuntu/Debian, wrapper ל-userdel) מוחק משתמש + תיקיית בית |
| `getent passwd` / `getent group` | רשימת כל המשתמשים / כל הקבוצות |
| `groups username` | הצגת כל הקבוצות שמשתמש שייך אליהן |
| `newgrp groupname` | מעבר זמני לקבוצה פעילה אחרת בתוך session |
| `setfacl` / `getfacl` | הרשאות מדויקות (ACL) מעבר ל-owner/group/other הרגיל |
| `visudo` | עריכה בטוחה של הרשאות sudo, במקום לערוך `/etc/sudoers` ישירות |
| `gpasswd -A admin group` | מינוי מנהל לקבוצה שיכול להוסיף/להסיר חברים בלי sudo |

## אופציות נוספות שכדאי להכיר — Windows

| פקודה | מה היא עושה |
|---|---|
| `Disable-LocalUser` / `Enable-LocalUser` | נעילת חשבון / פתיחתו בלי למחוק |
| `Get-LocalGroupMember -Group X` | הצגת כל החברים בקבוצה מסוימת |
| `net user` / `net localgroup` | פקודות legacy, עובדות בכל גרסת Windows כולל Server ישן |
| `Get-Acl` / `icacls` (בלי /grant) | בדיקת הרשאות קיימות לפני שינוי |
| `runas /user:X cmd` | הרצת פקודה כמשתמש אחר, המקביל הכי קרוב ל-`su` |
| `gpedit.msc` / `gpupdate` | Group Policy, לשליטה מתקדמת יותר מרמת domain |

**הערה**: ל-`last` (היסטוריית התחברויות) אין מקבילה ישירה ב-Windows.
הכי קרוב זה Event Viewer עם Event ID 4624, או `Get-WinEvent`.
`who` ו-`w` (מי מחובר עכשיו) כן יש מקבילה: `quser` / `query user`.

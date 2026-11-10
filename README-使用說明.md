# 甲業題庫 PWA＋雲端同步版

## 內容
- `index.html`：練習測驗主程式（保留原本 16 章節、PDF 匯入、練習/模擬考與錯題檢討）
- `manifest.webmanifest`、`service-worker.js`、圖示：讓網站可加入手機主畫面並快取基本頁面
- `supabase-schema.sql`：建立個人雲端題庫資料表及 Row Level Security 權限

## 重要：雲端同步需要一次性設定
這個資料夾本身不會自動產生雲端帳號或資料庫。需由你建立自己的 Supabase 專案，然後把網站部署到 HTTPS 網址。

### A. 建立 Supabase
1. 到 https://supabase.com 建立免費專案。
2. 開啟專案的 SQL Editor。
3. 將 `supabase-schema.sql` 全部貼上並執行。
4. 到 Project Settings → API，複製 Project URL 與 `anon` / `publishable` public key。
5. 不可把 `service_role` / secret key 貼到網頁。網頁只使用公開 anon/publishable key，資料存取由 SQL 的 RLS 政策限制為登入者自己的資料。
6. 若 Supabase Auth 開啟 Email Confirmation，註冊後先到信箱驗證，再回網頁登入。

### B. 部署網站（GitHub Pages 範例）
1. 建立 GitHub repository（可設 Private 或 Public；GitHub Pages 的方案限制依 GitHub 帳號方案而異）。
2. 將本資料夾內所有檔案放在 repository 根目錄。
3. Repository → Settings → Pages，選擇從 `main` 分支、`/(root)` 部署。
4. 等 GitHub Pages 顯示 HTTPS 網址後，以該網址在電腦與 iPhone 開啟。
5. 首次開啟請保持網路連線，讓瀏覽器下載 PDF.js、Supabase SDK 並安裝離線快取。

也可以部署到 Cloudflare Pages、Netlify 等提供 HTTPS 靜態網站託管的平台。

### C. 首次同步
1. 在電腦開啟部署後的 HTTPS 網址。
2. 展開「設定雲端服務與登入帳號」，填入 Supabase Project URL 和 anon/publishable key，按「儲存雲端設定」。
3. 註冊電子郵件與密碼並登入。
4. 匯入 PDF 題庫後，按「將本機資料上傳雲端」。
5. 在 iPhone Safari 開啟同一網址，填入同一組 Project URL/key，以同一帳號登入。
6. 按「從雲端下載到本機」，即可取得題庫與測驗紀錄。

### D. iPhone 加入主畫面
1. 使用 Safari 開啟網站 HTTPS 網址（不要用 LINE/其他 App 內建瀏覽器）。
2. 點 Safari 的「分享」圖示。
3. 選「加入主畫面」，再按「加入」。
4. 之後從主畫面「甲業題庫」圖示開啟。

## 資料同步規則與限制
- PDF 會在目前裝置的瀏覽器內解析；雲端同步的是「解析後的題目資料」和「測驗成績」，不是原始 PDF 檔案。
- 題庫匯入、測驗交卷後，若已登入且網路正常，程式會嘗試自動上傳；也可以手動按上傳/下載。
- 為避免不小心覆蓋另一台裝置的新資料，登入後不會自動下載或自動合併；請先決定要上傳還是下載。下載會覆蓋本機資料，上傳會覆蓋雲端資料。
- 同一帳號請避免同時在多台裝置編輯後各自上傳；目前採「整份資料覆蓋」策略，尚未做逐題衝突合併。
- PWA 可快取網站基本頁面；首次載入、登入與雲端同步需要網路。離線時可使用已快取頁面與本機題庫，但不同 iPhone/電腦的本機資料不會在離線時同步。
- 目前沿用原程式 PDF 文字解析器。掃描影像型 PDF、特殊排版或題目跨頁時，仍可能需要 OCR 或人工校正；匯入後請檢查章節統計。

## 本機測試
雙擊 `index.html` 可測試部分一般功能，但 PWA 安裝、Service Worker、跨裝置同步必須透過 HTTPS 網站使用。建議以部署後的 HTTPS 網址作正式使用。


## 錯題本功能
每次交卷後，答錯或未作答的題目會自動加入「我的錯題本」。同一題以章節、原題號及題目文字識別，重複答錯會累計次數。錯題本練習中答對的題目會標示為已訂正，不再列入待訂正練習；仍可在「已訂正」或「全部錯題」查看。錯題本會儲存在本機，並隨雲端上傳/下載同步。

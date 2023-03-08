# Service Learning Website

> There is another repo for solo practicing: 
> https://github.com/squidspirit/ServiceLearningWebsite

## 協作須知

> 這個 repo 只有魷魚和百寬有權限直接 commit 上來，其他人依照以下方法將此 repo fork 到自己的 github 上，往後透過 pull-request 的方式由魷魚百寬確認沒問題後，才會 merge 到這

### 建立 Fork 並 Clone

1. 點選右上方 `fork`，接著確認建立 fork 到自己的 github

![](https://i.imgur.com/NbaQObc.png)

![](https://i.imgur.com/vBqAolr.png)

2. 此時在自己的 repos 下可以看到 fork 出來的專案

![](https://i.imgur.com/wJtCDup.png)

3. 從自己 fork 出來的專案 clone 下來

![](https://i.imgur.com/thO6fzE.png)

4. 設定 upstream，輸入 `git remote add upstream git@github.com:squidspirit/service-learning-website.git`

5. 執行 `git remote -v`，確認是否有新增 `upstream` 了

![](https://i.imgur.com/qK689qQ.png)


### 推送 Commit 與 Pull-request

1. 在 VSCode 中顯示 `M` 或是 `U` 表示這個檔案沒有被放到暫存區，使用 `git add <檔案名稱>` 或是 `git add <路徑名稱>` 將目標加入暫存區

> 路徑為 `'.'` 時，表示終端機當下的目錄

> 可以分次進行 add，把確定改好的檔案 add 進去就好

![](https://i.imgur.com/4RxPfSk.png)

2. 被加入暫存區的檔案在 VSCode 中會顯示 `A`，取消追蹤可輸入指令 `git reset <檔案名稱>` 或 `git reset <路徑名稱>`

3. 所有確認好的更動都 add 完後，使用 `git commit -m "本次 commit 的說明"` 或 `git commit` 打開文字編輯器再輸入 commit 說明，此時所有已加入暫存區的檔案都會被 commit，被記錄成一個版本

![](https://i.imgur.com/rR4Q5Pl.png)

4. 此時所有版本紀錄都還在本地端，執行 `git push` 才會被上傳到 github，如果沒出現任何錯誤的話，可以到 github 去確認有沒有被上傳上去；如果有出現其他錯誤訊息，後面有可能會出現的錯誤

![](https://i.imgur.com/j8tsKFH.png)

5. 進到 pull-request 分頁，建立新的 pull-request

![](https://i.imgur.com/l11rjUa.png)

![](https://i.imgur.com/74AidQb.png)

![](https://i.imgur.com/HVSvU2R.png)

6. 魷魚百寬這邊收到 request 後確認沒問題就會 merge 進 upstream，但如果有一些疑慮，會留言並退回 request，修改好再重新 request 就好

### Fork 更新

> 務必於每次開始要寫 code 前做一次同步更新

1. 執行 `git fetch upstream`，將源專案同步到本地端

2. 執行 `git checkout main`，使目前分支位在 `main`

3. 執行 `git merge upstream/main`，將遠端版本更新 merge 進本地端，如果檔案沒有任何衝突，那就完成更新了

### 可能發生的錯誤

- 未設置使用者名稱、email
- 權限不符（未登入、未設定 ssh-key）
- 遠端有更新的版本
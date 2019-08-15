# 贡献项目

创建新的 [Issue](https://jira.itszfung.com) 到 Jira

在 [GitLab](https://gitlab.itszfung.com/jc/docker) 上 `clone` 到本地，并设置用户信息。

```bash
$ git clone $PROJECT_REPO
$ cd $PROJECT_DIR
```

修改代码后提交，并推送到仓库，注意修改提交消息为对应 Issue 号和描述。

```bash
$ git commit -a -m "修复 issue #JCXXX: 修复的描述"
$ git push
```

在 [GitLab](https://gitlab.itszfung.com/jc/docker) 上提交 `Merge Request`，并请维护者进行`Review`。[模板内容](./gitlab/MERGE_REQUEST_TEMPLATE.md)

## 排版规范

本文档遵循 [写作标准](https://wiki.itszfung.com/pages/viewpage.action?pageId=327758) 规范。

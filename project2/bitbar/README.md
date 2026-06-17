# Bitbar - 启动说明

本文档记录在本地复现 `bitbar` 实验环境的最小步骤（Rails 5 / Ruby 2.4）。

**先决条件**
- 已安装 `asdf`（用于管理 Ruby 版本）。
- 系统安装常见构建依赖（例如 `build-essential`, `libssl-dev`, `zlib1g-dev`, `libsqlite3-dev`, `libreadline-dev` 等）。

**常见网络问题**
- 若在编译 Ruby 时出现 `failed to download openssl-*.tar.gz`，请检查 DNS 是否将 `release-assets.githubusercontent.com` 或 `github.com` 指向本机（`127.0.0.1` / `::1`）。
- 临时解决（Linux 使用 systemd-resolved）：

```bash
# 临时使用公共 DNS（示例）
sudo resolvectl dns ens33 8.8.8.8 1.1.1.1
# 验证
resolvectl query release-assets.githubusercontent.com
```

- 恢复原先设置（将 `192.168.95.2` 替换为原 DNS）：

```bash
sudo resolvectl dns ens33 192.168.95.2
```

**安装 Ruby (示例，用 asdf)**

```bash
asdf plugin-add ruby || true
asdf install ruby 2.4.10
asdf global ruby 2.4.10

# 安装与 Rails 5 兼容的 bundler
gem install bundler -v 1.17.3 --no-document
```

**在 `bitbar` 目录安装依赖并启动**

```bash
cd /path/to/bitbar    # 替换为项目目录，例如 /mnt/hgfs/win_share/project2/bitbar
bundle install
# 若使用 sqlite（默认），创建数据库（如需要）
rake db:create

# 使用 bundler 启动服务器，绑定到所有接口以便从宿主访问
bundle exec rails server -b 0.0.0.0 -p 3000

# 打开浏览器访问： http://localhost:3000
```

**注意事项**
- Rails 源码在实验过程中不应修改（按课程要求）。
- 若本机系统 OpenSSL 版本过新导致 Ruby 2.4 编译失败，考虑使用 Docker 或虚拟机运行推荐的旧版系统镜像（例如 Ubuntu 16.04/18.04），或手动编译并指定 OpenSSL 1.1 并通过 `RUBY_CONFIGURE_OPTS="--with-openssl-dir=/path/to/openssl" asdf install ruby 2.4.10`。


# Publish to GitHub (hjGamma/capitalist-code-skill)

Local repo is ready at this directory (`main` @ initial commit). Push is blocked until GitHub auth for [hjGamma](https://github.com/hjGamma) is available.

## Option A — SSH (recommended)

1. Add this machine’s public key to GitHub → Settings → SSH and GPG keys:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFWQklO+B0FbeSURWXThQuJFwiehL7v2IcRDrIV2cDCc yinhaojie@nsfocus.com
```

2. Create the empty repo on GitHub (no README): https://github.com/new  
   - Owner: `hjGamma`  
   - Name: `capitalist-code-skill`  
   - Public

3. Push:

```bash
cd /home/gamma/project/capitalist-code-skill
git remote add origin git@github.com:hjGamma/capitalist-code-skill.git
git push -u origin main
```

## Option B — HTTPS + Personal Access Token

```bash
cd /home/gamma/project/capitalist-code-skill
git remote add origin https://github.com/hjGamma/capitalist-code-skill.git
git push -u origin main
# Username: hjGamma
# Password: <PAT with repo scope>
```

## Option C — GitHub CLI

```bash
gh auth login
cd /home/gamma/project/capitalist-code-skill
gh repo create hjGamma/capitalist-code-skill --public --source=. --remote=origin --push
```

After push, install:

```bash
./install.sh zh-CN   # or en
```

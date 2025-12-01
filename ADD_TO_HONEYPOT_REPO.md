# Instructions: Add Fly.io Files to AI-Cybersecurity_honeypot Repository

## Files to Copy

Copy these files from `SihleDladla.dev` workspace to your `AI-Cybersecurity_honeypot` repository:

1. `fly.toml` → Root of honeypot repo
2. `fly.backend.toml` → Root of honeypot repo  
3. `fly.frontend.toml` → Root of honeypot repo
4. `FLY_DEPLOYMENT.md` → Root of honeypot repo
5. `.dockerignore` → Root of honeypot repo (if not exists)
6. `Dockerfile.fly` → Root of honeypot repo (optional, if you don't have Dockerfile)

## Quick Copy Commands

### Option 1: Manual Copy
```bash
# Navigate to honeypot repo
cd ../AI-Cybersecurity_honeypot

# Copy files from portfolio repo
cp ../SihleDladla.dev/fly.toml .
cp ../SihleDladla.dev/fly.backend.toml .
cp ../SihleDladla.dev/fly.frontend.toml .
cp ../SihleDladla.dev/FLY_DEPLOYMENT.md .
cp ../SihleDladla.dev/.dockerignore .
cp ../SihleDladla.dev/Dockerfile.fly .
```

### Option 2: Using Git (if both repos are local)
```bash
# From SihleDladla.dev directory
cd ../AI-Cybersecurity_honeypot
git checkout -b fly-deployment
cp ../SihleDladla.dev/fly*.toml .
cp ../SihleDladla.dev/FLY_DEPLOYMENT.md .
cp ../SihleDladla.dev/.dockerignore .
cp ../SihleDladla.dev/Dockerfile.fly .
git add .
git commit -m "Add Fly.io deployment configuration"
git push origin fly-deployment
```

## File Locations in Honeypot Repo

```
AI-Cybersecurity_honeypot/
├── fly.toml                    ← Main Fly.io config
├── fly.backend.toml            ← Backend service config
├── fly.frontend.toml           ← Frontend service config
├── FLY_DEPLOYMENT.md           ← Deployment guide
├── .dockerignore               ← Docker ignore rules
├── Dockerfile.fly              ← Optional Dockerfile
├── docker-compose.yml          ← Your existing file
├── backend/
├── frontend/
└── ...
```

## After Adding Files

1. **Review and customize** `fly.toml` based on your project structure
2. **Update app names** in the `.toml` files if needed
3. **Commit to repository**:
   ```bash
   git add fly*.toml FLY_DEPLOYMENT.md .dockerignore Dockerfile.fly
   git commit -m "Add Fly.io deployment configuration for free hosting"
   git push
   ```
4. **Follow deployment guide** in `FLY_DEPLOYMENT.md`

## Next Steps

See `FLY_DEPLOYMENT.md` for complete deployment instructions!




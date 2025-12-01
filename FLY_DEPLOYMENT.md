# 🚀 Fly.io Deployment Guide - AI Cybersecurity Honeypot

## Why Fly.io?

- ✅ **100% FREE** - Generous free tier, no credit card required initially
- ✅ **Docker Support** - Native Docker and Docker Compose support  
- ✅ **Free PostgreSQL** - Managed PostgreSQL database included
- ✅ **Free Redis** - Can add Upstash Redis (free tier)
- ✅ **Auto-Wake** - Services wake automatically on request
- ✅ **Global Edge** - Fast worldwide deployment
- ✅ **No Sleep Limits** - Unlike Render, services stay accessible

## 📋 Prerequisites

1. **Sign up** at [fly.io](https://fly.io) (free account)
2. **Install Fly CLI**:
   ```bash
   # Windows (PowerShell - Run as Administrator)
   iwr https://fly.io/install.ps1 -useb | iex
   
   # macOS/Linux
   curl -L https://fly.io/install.sh | sh
   
   # Verify installation
   fly version
   ```

## 🚀 Quick Deployment (Single Service)

### Step 1: Login
```bash
fly auth login
```

### Step 2: Initialize App
```bash
cd AI-Cybersecurity_honeypot
fly launch
```
This will:
- Detect your Dockerfile or docker-compose.yml
- Ask for app name (suggest: `ai-cybersecurity-honeypot`)
- Create/update `fly.toml`
- Set up your app

### Step 3: Create PostgreSQL Database
```bash
fly postgres create --name ai-honeypot-db --region iad
fly postgres attach --app ai-cybersecurity-honeypot ai-honeypot-db
```

### Step 4: Create Redis (Using Upstash - Free)
```bash
# Option 1: Use Upstash Redis (Free tier)
# Sign up at https://upstash.com and create Redis instance
# Then set the URL as secret

# Option 2: Use Fly Redis (if available)
fly redis create --name ai-honeypot-redis
```

### Step 5: Set Environment Variables
```bash
# Database URL is automatically set when you attach PostgreSQL
# Set other required secrets
fly secrets set SECRET_KEY="your-secret-key-here" -a ai-cybersecurity-honeypot
fly secrets set REDIS_URL="redis://..." -a ai-cybersecurity-honeypot
fly secrets set ENVIRONMENT="production" -a ai-cybersecurity-honeypot

# View all secrets
fly secrets list -a ai-cybersecurity-honeypot
```

### Step 6: Deploy
```bash
fly deploy
```

### Step 7: Open Your App
```bash
fly open
```

## 🏗️ Multi-Service Deployment (Recommended)

For better separation, deploy backend and frontend separately:

### Deploy Backend API

```bash
# 1. Initialize backend app
fly launch -c fly.backend.toml

# 2. Create PostgreSQL
fly postgres create --name ai-honeypot-db --region iad
fly postgres attach --app ai-honeypot-api ai-honeypot-db

# 3. Set secrets
fly secrets set SECRET_KEY="your-secret-key" -a ai-honeypot-api
fly secrets set REDIS_URL="redis://..." -a ai-honeypot-api

# 4. Deploy backend
fly deploy -c fly.backend.toml

# 5. Get backend URL
fly status -a ai-honeypot-api
```

### Deploy Frontend

```bash
# 1. Initialize frontend app
fly launch -c fly.frontend.toml

# 2. Set backend API URL
fly secrets set REACT_APP_API_URL="https://ai-honeypot-api.fly.dev" -a ai-honeypot-frontend

# 3. Deploy frontend
fly deploy -c fly.frontend.toml

# 4. Open frontend
fly open -a ai-honeypot-frontend
```

## 🔧 Using Docker Compose

If your project uses `docker-compose.yml`, you have two options:

### Option 1: Convert to Fly.io Services
Deploy each service separately using the multi-service approach above.

### Option 2: Use Fly.io with Docker Compose
```bash
# Fly.io can work with Docker Compose
# Update fly.toml to use docker-compose
[build]
  dockerfile = "Dockerfile"

[deploy]
  release_command = "docker-compose up -d"
```

## 📊 Free Tier Limits

- **3 shared-cpu-1x VMs** (256MB RAM each) - Can upgrade to 512MB
- **3GB persistent volume storage**
- **160GB outbound data transfer/month**
- **Free PostgreSQL** (3GB storage, 1GB RAM)
- **Services auto-sleep** after 5 minutes inactivity (auto-wake on request)

## 🎯 Optimization Tips

1. **Combine Services**: Run multiple services in one VM if possible
2. **Use Auto-Sleep**: Services sleep when idle (saves resources)
3. **Optimize Docker Images**: Use multi-stage builds, smaller base images
4. **Environment Variables**: Use `fly secrets` for sensitive data
5. **Health Checks**: Configure health endpoints for better reliability

## 🔗 Useful Commands

```bash
# View logs
fly logs -a ai-cybersecurity-honeypot

# SSH into VM
fly ssh console -a ai-cybersecurity-honeypot

# Scale services
fly scale count 1 -a ai-cybersecurity-honeypot

# View app status
fly status -a ai-cybersecurity-honeypot

# Open app in browser
fly open -a ai-cybersecurity-honeypot

# View secrets
fly secrets list -a ai-cybersecurity-honeypot

# Set secret
fly secrets set KEY="value" -a ai-cybersecurity-honeypot

# Remove secret
fly secrets unset KEY -a ai-cybersecurity-honeypot

# View PostgreSQL connection
fly postgres connect -a ai-honeypot-db

# View database status
fly postgres status -a ai-honeypot-db
```

## 🆘 Troubleshooting

### Services Won't Start
```bash
# Check logs
fly logs -a ai-cybersecurity-honeypot

# Check status
fly status -a ai-cybersecurity-honeypot

# Verify environment variables
fly secrets list -a ai-cybersecurity-honeypot
```

### Database Connection Issues
```bash
# Verify PostgreSQL is running
fly postgres status -a ai-honeypot-db

# Check DATABASE_URL is set
fly secrets list -a ai-cybersecurity-honeypot | grep DATABASE

# Connect to database
fly postgres connect -a ai-honeypot-db
```

### Out of Memory
```bash
# Increase memory in fly.toml
[[vm]]
  memory_mb = 512  # or 1024

# Redeploy
fly deploy
```

### Port Issues
- Ensure `internal_port` in `fly.toml` matches your app's port
- Check `PORT` environment variable is set correctly

## 📝 Environment Variables Setup

Create a `.env.fly` file with your secrets (don't commit this):

```env
SECRET_KEY=your-secret-key-here
DATABASE_URL=postgresql://... (auto-set by Fly)
REDIS_URL=redis://...
ENVIRONMENT=production
```

Then set them:
```bash
fly secrets import .env.fly -a ai-cybersecurity-honeypot
```

## 🎓 Demo Setup

For demo purposes, you can:

1. **Generate synthetic attacks**:
   ```bash
   fly ssh console -a ai-cybersecurity-honeypot
   python tools/gen_attacks.py --count 100
   ```

2. **Access dashboard**: `fly open -a ai-honeypot-frontend`

3. **View API docs**: `https://ai-honeypot-api.fly.dev/docs`

## 📚 Resources

- [Fly.io Documentation](https://fly.io/docs/)
- [Fly.io Pricing](https://fly.io/docs/about/pricing/)
- [Docker on Fly.io](https://fly.io/docs/languages-and-frameworks/dockerfile/)
- [PostgreSQL on Fly.io](https://fly.io/docs/postgres/)

## ⚠️ Important Notes

1. **Legal Compliance**: Ensure deployment complies with Fly.io's terms of service
2. **Educational Use**: This is for educational/demo purposes only
3. **Data Privacy**: Be mindful of data collection and storage
4. **Resource Limits**: Monitor usage to stay within free tier limits

---

**Ready to deploy?** Start with `fly launch` and follow the prompts!

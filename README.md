# terraform-prac

## 準備

### git-secrets 設定

```sh
brew install git-secrets
gti secrets --install
git secrets --register-aws --global
```

### aws コマンド

```sh
brew install awscli
```

```sh
$ aws --version                             
aws-cli/2.17.1 Python/3.11.9 Darwin/23.5.0 source/arm64
```

アクセスキーとシークレットキーを設定する

```sh
$ aws configure
AWS Access Key ID [None]: Access Key ID
AWS Secret Access Key [None]: Secret Access Key
Default region name [None]: ap-northeast-1
Default output format [None]: 未入力
```

```sh
export AWS_ACCESS_KEY_ID=Access Key ID
export AWS_SECRET_ACCESS_KEY=Secret Access Key
export AWS_DEFAULT_REGION=ap-northeast-1
```

アカウントIDを取得する

```sh
aws sts get-caller-identity --query Account --output text
123456789012
```

### terraform コマンド

```sh
brew install asdf
asdf plugin add terraform
asdf list-all terraform
asdf install terraform 1.9.1
asdf local terraform 1.9.1
```

```sh
$ terraform --version
Terraform v1.9.1
on darwin_arm64
```


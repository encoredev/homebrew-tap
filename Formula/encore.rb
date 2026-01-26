class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.53.8"
    checksums = {
        "darwin_arm64" => "68d2c2dd60aeffdfeddc3580407a7dafce6b4c100ad1a94bd19f37983fa9cf4e",
        "darwin_amd64" => "41d0f83cdbb04c9db31090f0e59fbfeca5039d1358d0a197cb992c97b9ccca21",
        "linux_arm64"  => "fb44461d4eec270f86db74d8f2cf76d77c519bedfff6000e672551bfd0ceb02a",
        "linux_amd64"  => "1c1aaba7d7140b28693e2faca2340ff83fde8b5e2a4394583534c7c9d7b64301",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end

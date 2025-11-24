class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.11"
    checksums = {
        "darwin_arm64" => "b108b91bd7b402a7920fd0d3c5829ba075a68c1f491b5214bf851a10d55c0e61",
        "darwin_amd64" => "5847724e06c1da8509dd94c25cfd889b94fffaeebbd0c6b3dbfdc1cf8b28e9ff",
        "linux_arm64"  => "6b6bf1fc56762219a38eb7811e6d38e32aceb543d50ac186ca32fd43a26496d5",
        "linux_amd64"  => "3862448264215fdf7f3c02eb3ce8c299d1ce2dff197ad83c770d9647d50b8dd0",
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

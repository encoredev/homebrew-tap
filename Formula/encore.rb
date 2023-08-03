class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.23.2"
    checksums = {
        "darwin_arm64" => "14e61d26047fb5af658d12a05970888db1deb111f0abc4f16dcddb5fdddb89bc",
        "darwin_amd64" => "9003cea690c658735b53990663f1701df8d21b6c0bcd0c3f57ed43d17bdfa942",
        "linux_arm64"  => "db9a8f1052f25bf7de5dab77e85ccdd662d85fde7190e71198bf52f843fe36f9",
        "linux_amd64"  => "36cf6af1c1f20d7c208f577fe5be353b80ad59f4680a32c548990961160a7d0f",
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

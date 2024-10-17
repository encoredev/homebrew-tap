class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.42.0"
    checksums = {
        "darwin_arm64" => "1a1e42f41835cb1eff806b64c35f59f3668d7ef84ff6b7d466678c2c3f24d97e",
        "darwin_amd64" => "0c072f87ae9889bee7df448b6ca76ea32f093f40140bcc25cdf6a81cf0abbdc9",
        "linux_arm64"  => "db019dce2ccd6df2471933dfa48f6f054ef6c0dc1a3732f02f6d157a565777bd",
        "linux_amd64"  => "562c8d475bcd5a8e48c030302dd6cb0f1a3ac35ed3b41250aa28426f56327962",
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

class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.20.4"
    checksums = {
        "darwin_arm64" => "de515c1fc5233f1983d51a675d3a29fd85326c9d645c61364afe6f520cf4f136",
        "darwin_amd64" => "e23759ac106fbc5773692f5fa6c095c832f83b715d42a5d59d161ea756ed2fe2",
        "linux_arm64"  => "a9d88447acd727e4bcb7f555160ec1df85cead0da71519505849c0e502c531f0",
        "linux_amd64"  => "9c4c694619e6c5356aef6a36779f656132498fd131aef5176441f96078588a7c",
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

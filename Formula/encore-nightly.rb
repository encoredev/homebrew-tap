class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0-nightly.20231128"
    checksums = {
        "darwin_arm64" => "c2cb2df7d5a6e881bb64d660114da5f45868d0006b57b010b261feb7365b8661",
        "darwin_amd64" => "b4dfc29932f9d68451efc565a004a7494cc4b17482a79f034b1f78869c176b5c",
        "linux_arm64"  => "dbf03f6f23cbe08fef4661013534d1f49b0f15069ea27655b5f11a50cbbe9614",
        "linux_amd64"  => "4dbf4bddd7afd72ef85fd77ef7100299b0fb54a7a6b5fc46d4a905775f829b37",
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

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end

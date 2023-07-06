class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230706"
    checksums = {
        "darwin_arm64" => "48e58f36d1c2b0573bdf398e272d931a44971703a50f97cb3bf2467456b65fb7",
        "darwin_amd64" => "81ad4da1687d7ae8f20e70ba93b9aaa1006b29b64262cb7e5293640916d20eee",
        "linux_arm64"  => "12c3b9aa6a0538af57ebd706c24bfde16eafff6c3b0158cfefe2ddd0718f06ac",
        "linux_amd64"  => "e62bcb86c76871b0ec0ce9892f134d8b8f2cacf3a15d45ceb30d7b6eed30bbd5",
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

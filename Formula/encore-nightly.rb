class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230405"
    checksums = {
        "darwin_arm64" => "6e39d54c8b8bf255d6efef03d5f886ec9843b4eec8a420a2396780fbeaa0bd95",
        "darwin_amd64" => "b40cae02170b1f87b284ace027005afa2f6c98fe49dbca010c14263ff9174ccf",
        "linux_arm64"  => "bdb569fd408a1a08ffa7dfdef386d0ff2eb0a3a55a4251f76d36c27799b75e53",
        "linux_amd64"  => "f79bc8185f6e8e228d2724dd7de6ec8a54437b66374953471e2d3600928f80ee",
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

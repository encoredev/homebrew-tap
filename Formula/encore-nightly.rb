class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230601"
    checksums = {
        "darwin_arm64" => "2570c3e6ca45a40a0c5e9a364790e93fabe6cd9380213471d73559428c5ca0ee",
        "darwin_amd64" => "9f3c40695be3b540095c734e11520a7d3ab88dc683bc0b7e5ddc335e760133c6",
        "linux_arm64"  => "99430b2f6422095a147e29dfbcdec5c6919ff035bbe3f816d640d16110823b99",
        "linux_amd64"  => "ba02db6652ea5fe674f10c3ac38ac3fafc7e8ffda54837f14b281183277293a3",
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

class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.31.2"
    checksums = {
        "darwin_arm64" => "a120b5625ac33eba486537f2721435120cf29b9f82868aad8ab1ea0305f7cf43",
        "darwin_amd64" => "935428aec4408af3596cb0250566f089273b66f57ff6000228e03b2f6770d048",
        "linux_arm64"  => "9327329621905e56fcdc4bdb42efb3e362c1691710b7d5ddef03e2690a46690b",
        "linux_amd64"  => "32d6a999f5ee53d0efea925d9f16a07e8f6e85e58292a2730aa224422b5449c9",
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

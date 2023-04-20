class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230420"
    checksums = {
        "darwin_arm64" => "654b79c5a0079b88e4c2a2e4917fe3fe720a3a5b4ff562fbaac24ce3be4d3cdd",
        "darwin_amd64" => "480acdc996137f163b89d46654cc2f99fbf54142b733ca0ffe6bbf8e055240b6",
        "linux_arm64"  => "c3d70d949b3f47053d2a1ff0880c6ceed01c045ce36be60bac6fff99662301e0",
        "linux_amd64"  => "12947b24aff8efe4aec8b10cd1faa3ab8b666d7cf5a904ca45029871e9f93097",
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

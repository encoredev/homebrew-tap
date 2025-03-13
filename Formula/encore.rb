class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.8"
    checksums = {
        "darwin_arm64" => "ed2e679de24864150fd6e3bcaed8281cc01f89712a9a54eec19f816c5d54f997",
        "darwin_amd64" => "ecd874ae68822bd55ade192a77218f50591694e8a01d8e1869ffa5eb156fc974",
        "linux_arm64"  => "58b11d21e3c2a0238a9aa4de56816cfb1fae2379446a19a9f6db63c5206c01b6",
        "linux_amd64"  => "7831f2956ea58d0c09a337fbdaa395e737e74853c50c6ab993d0035c3254a2ee",
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

class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.5"
    checksums = {
        "darwin_arm64" => "a8f2b0a25c2abc18ba37be5c25338879c89d9cb0bf0e49178b5df5035c0698ab",
        "darwin_amd64" => "466192fb91c7431d29d512fd7d2aed9a4799e7e28e88a58164cb1ebd572e2784",
        "linux_arm64"  => "26181cc53c12b9ab43c630c40ccdfe68b2f3f330e064eb0709d46dca532b3a74",
        "linux_amd64"  => "0aa393684811548eec3ff5b5c6651277f19e6ceb9d0f4d48f3f3efb006d70130",
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
